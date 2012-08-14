class UserSession < Authlogic::Session::Base
  remember_me_for 2.weeks
  remember_me false
  after_create :update_user_activity
  find_by_login_method :find_by_email

  def reset_persistence_token
    record.reset_persistence_token
  end

  def self.oauth_consumer
      OAuth::Consumer.new(AuthlogicConnect.config[:connect][:twitter][:key], AuthlogicConnect.config[:connect][:twitter][:secret],
      { :site=>"http://api.twitter.com",
        :authorize_url => "https://api.twitter.com/oauth/authorize" })
  end
  
  private
  
  def update_user_activity
    controller.session[:last_active] = self.record.sb_last_seen_at
    controller.session[:topics] = controller.session[:forums] = {}
    self.record.update_last_seen_at
  end
end
