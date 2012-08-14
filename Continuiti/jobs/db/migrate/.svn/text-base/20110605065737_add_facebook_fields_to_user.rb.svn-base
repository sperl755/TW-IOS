class AddFacebookFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :facebook_friends_count, :integer
  end

  def self.down
    remove_column :users, :facebook_friends_count
  end
end
