class ReferralsController < BaseController
  before_filter :load_user
  before_filter :require_current_user
  # GET /referrals
  # GET /referrals.xml
  def index
    @referred_users = @user.referred_users
    @referral_bonus = ReferralBonus.first
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @referrals }
    end
  end

  
  
  private
  def load_user
    @user = current_user
  end
end
