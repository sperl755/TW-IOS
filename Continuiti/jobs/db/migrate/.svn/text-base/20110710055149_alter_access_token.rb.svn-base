class AlterAccessToken < ActiveRecord::Migration
  def self.up
    rename_column :access_tokens, :type, :oauth_type
  end

  def self.down
    rename_column :access_tokens, :oauth_type, :type
  end
end
