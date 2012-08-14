class AddCoreFieldToUsers < ActiveRecord::Migration
  def self.up
	    add_column :users, :first_name, :string
	    add_column :users, :middle_name, :string
	    add_column :users, :last_name, :string
	    add_column :users, :phone, :string
	    add_column :users, :transportation_access, :string
	    add_column :users, :work_type, :string
  end

  def self.down
	    remove_column :users, :first_name
	    remove_column :users, :middle_name
	    remove_column :users, :last_name
	    remove_column :users, :phone
	    remove_column :users, :work_type
  end
end
