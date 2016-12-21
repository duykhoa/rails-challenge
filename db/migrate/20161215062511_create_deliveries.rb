class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|

      t.references :ratable, polymophic: true, index: true
      t.timestamps null: false
    end
  end
end
