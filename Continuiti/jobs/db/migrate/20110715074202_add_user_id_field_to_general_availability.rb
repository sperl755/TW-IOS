class AddUserIdFieldToGeneralAvailability < ActiveRecord::Migration
  def self.up
    add_column :general_availabilities, :user_id, :integer
    add_index :general_availabilities, :user_id
  end

  def self.down
    remove_column :general_availabilities, :user_id
  end
end
