class RemoveReferenceFromDeliveryToRates < ActiveRecord::Migration
  def up
    remove_column :deliveries, :ratable_id
  end

  def down
    add_reference :deliveries, :rates, polymophic: true
  end
end
