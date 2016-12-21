class AddOrderIdToMeal < ActiveRecord::Migration
  def up
    add_column :meals, :order_id, :integer
  end

  def down
    remove_column :meals, :order_id
  end
end
