require 'rails_helper'

describe Meal, type: :model do
  it "create meal" do
    meal = Meal.create(meal_name: "Chicken Rice")
  end
end
