class AddRatesPointToDeliveries < ActiveRecord::Migration
  def up
    add_column :deliveries, :rate_point, :float, default: 4
  end

  def down
    remove_column :deliveries, :rate_point
  end
end
