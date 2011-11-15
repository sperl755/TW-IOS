class ReferralBonusController < BaseController
  before_filter :admin_required
  def index
    @referral_bonuses = ReferralBonus.all
  end

  def update
    @referral_bonus = ReferralBonus.find(params[:id])
    if @referral_bonus.update_attributes(params[:referral_bonus])
      render :update do |page|
        page.replace_html "referral_bonus_form_#{@referral_bonus.id}",  :partial => 'show_a_referral_bonus', :locals =>{:referral_bonus => @referral_bonus}
      end
    end
  end

  def temp
    @user = User.find 2
    if @user.referrer_referrals
      @user.referrer_referrals.set_referral_earning(1000)
      redirect_to :back
    end
  end

end
