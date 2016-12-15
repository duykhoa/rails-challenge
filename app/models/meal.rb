class Meal < ActiveRecord::Base
  has_many :rates, as: :ratable
end
