class AddRatesToMeals < ActiveRecord::Migration
  def up
    add_column :meals, :rate_point, :float, default: 4
  end

  def down
    remove_column :meals, :rate_point
  end
end
