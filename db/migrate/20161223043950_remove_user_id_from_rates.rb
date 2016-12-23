class RemoveUserIdFromRates < ActiveRecord::Migration
  def up
    remove_column :rates, :user_id
  end

  def down
    add_reference :rates, :user
  end
end
