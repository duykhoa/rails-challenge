class Order < ActiveRecord::Base
  has_many :meals
  has_one :delivery
end
