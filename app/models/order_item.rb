class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :meal
  has_one :rate, as: :ratable

  delegate :meal_name, to: :meal
end
