class AddColumnExpiredToReferrals < ActiveRecord::Migration
  def self.up
    add_column :referrals, :expired, :boolean, :default => false
  end

  def self.down
    remove_column :referrals, :expired
  end
end
