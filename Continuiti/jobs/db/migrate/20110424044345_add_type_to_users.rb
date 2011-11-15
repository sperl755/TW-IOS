class AddTypeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :account_type, :boolean, :default => 0
  end

  def self.down
      remove_column :users, :account_type
  end
end
#ALTER TABLE `c_engine_development`.`users` DROP COLUMN `type`;
