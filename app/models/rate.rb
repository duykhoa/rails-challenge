class Rate < ActiveRecord::Base
  belongs_to :ratable, polymorphic: true
end
