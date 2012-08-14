class AddUserToOauth < ActiveRecord::Migration
  def self.up
    add_column :users, :twitter_screen_name, :string
    add_column :users, :oauth_secret, :string
    add_column :users, :oauth_token, :string
  end

  def self.down
    remove_column :users, :twitter_screen_name
    remove_column :users, :oauth_secret
    remove_column :users, :oauth_token
  end
end
