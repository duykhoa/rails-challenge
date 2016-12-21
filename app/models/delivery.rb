class Delivery < ActiveRecord::Base
  has_one :rate, as: :ratable
end
