class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.integer :user_id

      t.integer :ratable_id
      t.string :ratable_type
      t.integer :point

      t.timestamps null: false
    end

    add_index :rates, [:ratable_type, :ratable_id]
  end
end
