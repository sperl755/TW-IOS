class AddColumnMaximumPerUserToReferralBonus < ActiveRecord::Migration
  def self.up
    add_column :referral_bonus, :maximum_per_user, :integer
    ReferralBonus.delete_all
    ReferralBonus.create(:percent => 2.3, :maximum_per_user => 50, :maximum => 1000)
  end

  def self.down
    remove_column :referral_bonus, :maximum_per_user
  end
end
