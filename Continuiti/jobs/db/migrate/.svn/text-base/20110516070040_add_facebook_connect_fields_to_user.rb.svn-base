class AddFacebookConnectFieldsToUser < ActiveRecord::Migration
	def self.up
		add_column :users, :name, :string
		add_column :users, :facebook_username, :string
		add_column :users, :facebook_uid, :integer, :limit => 8
		add_column :users, :locale, :string
		add_column :users, :website, :string
	end

	def self.down
    remove_column :users, :website
    remove_column :users, :locale
    remove_column :users, :facebook_username
    remove_column :users, :facebook_uid
    remove_column :users, :name
	end
end