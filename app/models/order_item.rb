class OrderItem < ActiveRecord::Base
  belongs_to :meal
  has_one :rate, as: :ratable
end
