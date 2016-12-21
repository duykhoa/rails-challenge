class Order < ActiveRecord::Base
  has_many :order_items
  has_one :delivery
end
