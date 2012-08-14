class CreateReferrals < ActiveRecord::Migration
  def self.up
    create_table :referrals do |t|
      t.integer :referrer_id
      t.integer :referred_id

      t.timestamps
    end
  end

  def self.down
    drop_table :referrals
  end
end
