class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :meal_name
      t.references :ratable, polymophic: true, index: true

      t.timestamps null: false
    end
  end
end
