require 'rails_helper'

describe Meal, type: :model do
  it "create meal" do
    meal = Meal.create(meal_name: "Chicken Rice")
  end

  describe "update_rate_point" do
    def assert_meal_rate_point_with(rates, expected_rate_point)
      meal = Meal.create

      rates.each do |i|
        order_item = OrderItem.create(meal: meal)
        rate = order_item.build_rate
        rate.point = i
        rate.save
      end

      Meal.update_rate_point
      meal.reload
      expect(meal.rate_point).to eq expected_rate_point
    end

    it "with one rate" do
      assert_meal_rate_point_with([1], 1)
      assert_meal_rate_point_with([2], 2)
      assert_meal_rate_point_with([5], 5)
    end

    it "with rates" do
      assert_meal_rate_point_with([1,2,3], 2)
      assert_meal_rate_point_with([1,2,3,4,5,1,1,1], 2.25)
    end
  end
end
