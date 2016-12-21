class AddOrderIdToDelivery < ActiveRecord::Migration
  def up
    add_column :deliveries, :order_id, :integer
  end

  def down
    remove_column :deliveries, :order_id
  end
end
