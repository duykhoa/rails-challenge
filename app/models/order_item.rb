class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :meal
  has_one :rate, as: :ratable
  has_one :comment, as: :commentable

  delegate :meal_name, to: :meal
  delegate :rate_point, to: :meal
end
