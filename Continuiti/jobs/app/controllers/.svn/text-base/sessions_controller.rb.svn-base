# This controller handles the login/logout function of the site.  
class SessionsController < BaseController
  if AppConfig.closed_beta_mode
    skip_before_filter :beta_login_required
  end  
  
  def index
    redirect_to :action => "new"
  end  
  
  def new
    redirect_to user_path(current_user) and return if current_user
    @user_session = UserSession.new
    render :layout => 'beta' if AppConfig.closed_beta_mode
  end
  
  def create
    @user_session = UserSession.new(:login => params[:login], :password => params[:password], :remember_me => params[:remember_me])
    if @user_session.save
      current_user = @user_session.record #if current_user has been called before this, it will ne nil, so we have to make to reset it
      if !current_user.facebook_uid.nil?
        @u = User.find_by_id(current_user.id)
        User.facebook_details(@u,facebook_session)
        #@u.activate
        @u.role_id = 3
        @u.activated_at =  Time.now
        @u.activation_code = nil
        @u.save_with_validation(false)
        @user = User.update_previous_user(@u)
        @user.reset_persistence_token
        @user.save_with_validation(false)
        UserSession.create(@user, false)
      end
      flash[:notice] = :thanks_youre_now_logged_in.l
      redirect_back_or_default(dashboard_user_path(current_user))
    else
      messages = @user_session.errors.map{|message| message};
      logger.debug("XXXXXXXXXXX #{messages}")
      flash[:notice] = :uh_oh_we_couldnt_log_you_in_with_the_username_and_password_you_entered_try_again.l
      redirect_to teaser_path and return if AppConfig.closed_beta_mode
      render :action => :new
    end
  end

  def twitter_authenticate
    @request_token = UserSession.oauth_consumer.get_request_token
    session[:request_token] = @request_token.token
    session[:request_token_secret] = @request_token.secret
    # Send to twitter.com to authorize
    redirect_to @request_token.authorize_url
    return
  end

  def twitter_callback
    @request_token = OAuth::RequestToken.new(UserSession.oauth_consumer, session[:request_token], session[:request_token_secret])
    # Exchange the request token for an access token.
    @access_token = @request_token.get_access_token
    @response = UserSession.oauth_consumer.request(:get,'/account/verify_credentials.json', @access_token, { :scheme => :query_string })
    case @response
      when Net::HTTPSuccess
      user_info = JSON.parse(@response.body)
      unless user_info['screen_name']
        flash[:notice] = "Authentication failed"
        redirect_to :action => :index
        return
      else
        user = User.update_oauth_user(@access_token, user_info,"twitter")
        @u = User.find_by_id(user.id)
        @u.reset_persistence_token
        @u.save_with_validation(false)
        @u.activated_at = Time.now
        @u.activation_code = nil
        @u.save_with_validation(false)
        @user_session = UserSession.create(@u,false)
        current_user = @user_session.record
        pp current_user
        flash[:notice] = "You have successfully logged in with twitter"
        redirect_back_or_default(dashboard_user_path(current_user))
      end
    end
  end
  
  def destroy
    current_user_session.destroy if current_user_session
    clear_facebook_session_information()
    flash[:notice] = :youve_been_logged_out_hope_you_come_back_soon.l
    redirect_to new_session_path
  end
  
end
