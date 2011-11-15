class CreateReferralBonus < ActiveRecord::Migration
  def self.up
    create_table :referral_bonus do |t|
      t.float :percent
      t.integer :maximum

      t.timestamps
    end
  end

  def self.down
    drop_table :referral_bonus
  end
end
