require 'rails_helper'

describe User, type: :model do
  describe "ratable?" do
    it "no order" do
      user = User.create(email: "test@gmail.com", password: "abcdefghik")

      order_id = 1
      expect(user.ratable?(order_id)).to be true
    end

    context "with order" do
      it "return false" do
        user = User.create(email: "test@gmail.com", password: "abcdefghik")

        order = user.orders.create

        meal = Meal.create
        order_item = OrderItem.create(order: order, meal: meal)

        rate = order_item.build_rate
        rate.point = 3
        rate.save

        expect(user.ratable?(order.id)).to be false
      end

      it "return true" do
        user = User.create(email: "test@gmail.com", password: "abcdefghik")

        order = user.orders.create

        meal = Meal.create
        order_item = OrderItem.create(order: order, meal: meal)

        expect(user.ratable?(order.id)).to be true
      end

      it "return false for multiple orders, only one get feedback" do
        user = User.create(email: "test@gmail.com", password: "abcdefghik")

        order = user.orders.create

        meal = Meal.create
        meal2 = Meal.create

        order_item = OrderItem.create(order: order, meal: meal)
        rate = order_item.build_rate
        rate.point = 1
        rate.save

        order_item2 = OrderItem.create(order: order, meal: meal)
        order_item3 = OrderItem.create(order: order, meal: meal2)

        expect(user.ratable?(order.id)).to be false
      end
    end
  end
end
