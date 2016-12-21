class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :qty
      t.references :meal
      t.references :order
    end
  end
end
