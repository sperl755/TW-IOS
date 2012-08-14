# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  # Scrub sensitive parameters from your log
  include AuthenticatedSystem
  include LocalizedApplication
  #before_filter :set_facebook_session
  #helper_method :facebook_session

  before_filter :redirect_to_endorse_friend

  # filter_parameter_logging :password
  private

  def redirect_to_endorse_friend
    if current_user
      unless session[:user_request_endorse_id].blank?
        user_request_endorse_id = session[:user_request_endorse_id]
        session[:user_request_endorse_id] = nil
        redirect_to new_endorsement_url(:user_requesting_endorse_id => user_request_endorse_id)
      end
    end
  end

  def current_cart
    #    session[:cart_id] = nil
    if session[:cart_id]
      @current_cart ||= Cart.find(session[:cart_id])
      session[:cart_id] = nil if @current_cart.purchased_at
    end
    if session[:cart_id].blank? 
      @current_cart = Cart.create!
      session[:cart_id] = @current_cart.id
    end
    @current_cart
  end

  def set_cart_item(cart, job)
    cart_item = CartItem.find_or_initialize_by_cart_id_and_job_id(cart.id, job.id)
    cart_item.quantity += 1 unless cart_item.id.nil?#new record or not
    cart_item.unit_price = job.required_job_investment
    cart_item.save
    cart_item
  end



  def check_admin_access
    unless current_user && current_user.admin?
      flash[:notice] = "You are not allowed for the requested page."
      redirect_to login_url
    end
  end
  
  #  def check_ownership(classname,id)
  #    unless admin?
  #      klass = classname.constantize
  #      object = klass.find_by_id(id)
  #      if object.user_id != current_user.id
  #        flash[:notice] = "You are not allowed for the requested page."
  #        redirect_to login_url and return false
  #      end
  #    end
  #  end
  
  def admin_required
    current_user && current_user.admin? ? true : access_denied
  end
  
  def admin_or_moderator_required
    current_user && (current_user.admin? || current_user.moderator?) ? true : access_denied
  end
  
  def find_user
    if @user = User.active.find(params[:user_id] || params[:id])
      @is_current_user = (@user && @user.eql?(current_user))
      unless logged_in? || @user.profile_public?
        flash[:error] = :this_users_profile_is_not_public_youll_need_to_create_an_account_and_log_in_to_access_it.l
        access_denied
      else
        return @user
      end
    else
      flash[:error] = :please_log_in.l
      access_denied
    end
  end
  
  def require_current_user
    @user ||= User.find(params[:user_id] || params[:id] )
    unless admin? || (@user && (@user.eql?(current_user)))
      redirect_to :controller => 'sessions', :action => 'new' and return false
    end
    return @user
  end
  
  def check_current_user
    redirect_to :controller => 'sessions', :action => 'new' and return false unless current_user
    return true
  end
  
  def set_layout
    admin? ? "admin" : "application"
  end
  
  
end
