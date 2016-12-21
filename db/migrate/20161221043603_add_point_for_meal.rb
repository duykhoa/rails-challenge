class AddPointForMeal < ActiveRecord::Migration
  def change
    add_column :meals, :rate_point, :float
  end
end
