class Referral < ActiveRecord::Base
  belongs_to :referrer, :class_name => "User"
  belongs_to :referred, :class_name => "User"

  has_many :payments, :as => :payable

  protected
  def set_referral_earning(income)
    unless self.expired?
      fund_amount = income.to_f * referral_bonus.percent / 100
      if (fund_amount + total_earnings_for_this_referred) > referral_bonus.maximum_per_user
        fund_amount = (fund_amount + total_earnings_for_this_referred) - referral_bonus.maximum_per_user
        expire
      end
      if (fund_amount + total_earnings) > referral_bonus.maximum
        (fund_amount + total_earnings) - referral_bonus.maximum
        fund_amount = expire_all
      end
      self.payments.create(:receiver => self.referrer, :amount => fund_amount, :payer => self.referred )
    end
  end

  private
  def expire
    self.update_attribute(:expired, true)
  end

  def expire_all
    Referral.update_all({:expired => true}, ["referrer_id = ?", self.referrer.id])
  end
  
  def total_earnings_for_this_referred
    self.payments.sum(:amount)
  end

  def total_earnings
    self.referrer.received_from_referrals.sum(:amount)
  end

  def referral_bonus
    ReferralBonus.find(:all).first
  end
end
