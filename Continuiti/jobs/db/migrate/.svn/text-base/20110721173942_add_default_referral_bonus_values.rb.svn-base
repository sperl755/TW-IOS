class AddDefaultReferralBonusValues < ActiveRecord::Migration
  def self.up
    ReferralBonus.create(:percent => 2.5, :maximum => 1000, :maximum_per_user => 50)
  end

  def self.down
  end
end
