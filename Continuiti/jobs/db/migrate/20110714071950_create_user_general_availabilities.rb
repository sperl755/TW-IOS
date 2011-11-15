class CreateUserGeneralAvailabilities < ActiveRecord::Migration
  def self.up
    create_table :user_general_availabilities do |t|
      t.integer :user_id
      t.integer :general_availability_id

      t.timestamps
    end
    add_index(:user_general_availabilities, [:user_id, :general_availability_id])
  end

  def self.down
    drop_table :user_general_availabilities
  end
end
