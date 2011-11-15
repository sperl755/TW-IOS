class UserNotifier < ActionMailer::Base
  #this action is rewritten from CE
  def signup_invitation(email, user, message, invite_code)
    setup_sender_info
    @recipients  = "#{email}"
    @subject     = "#{:would_like_you_to_join.l(:user => user.login, :site => AppConfig.community_name)}"
    @sent_on     = Time.now
    @body[:user] = user
    @body[:url]  = signup_by_id_url(user, invite_code)
    @body[:message] = message
  end  
end
