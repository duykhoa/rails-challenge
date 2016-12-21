class AddRatePointToDelivery < ActiveRecord::Migration
  def change
    add_column :deliveries, :rate_point, :float
  end
end
