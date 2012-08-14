class ApisController < BaseController
  layout false
  before_filter :check_user, :only =>[:job_list, :create_message, :job]

  def login
    logger.info("Login api post request...")
    logger.info(Time.now)
    user_session = UserSession.new(:login => params[:login], :password => params[:password], :remember_me => params[:remember_me])
    if user_session.save

      current_user = user_session.record

      api = Api.find_by_user_id(current_user.id)
      if api.nil?
        api = Api.create(:user_id=>current_user.id, :key=> Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join ))
      else
        api.update_attribute(:key,Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join ))
      end
       render :text=>api.key
    else
      logger.info("Login failed...")
      render :text=>"no"
    end
     
  end

  def signup
    logger.info("Signup api post request...")
    logger.info(Time.now)
    user = User.new(:name=>params[:name], :email => params[:email], :password => params[:password], :password_confirmation=>params[:password_confirmation], :birthday => Date.parse((Time.now - 25.years).to_s), :account_type => 3)
    if user.save
      user.activated_at = Time.now
      user.activation_code = nil
      user.save
      logger.info("Signup successful...")
      email=user.email
      logger.info(email)
      render :text=>"Thanks for signup, an email has sent to you. Please activate the account."
    else
      logger.info("signup validation failed...")
      error_msg = user.errors.full_messages.join('<br />')
      render :text=>error_msg
    end
  end
  
  def fb_login
    facebook = Hash.new
    facebook['email'] = params[:email]
    facebook['name'] = params[:name]
    facebook['first_name'] = params[:first_name].nil? ? "" : params[:first_name]
    facebook['last_name'] = params[:last_name].nil? ? "" : params[:last_name] 
    facebook['birthday'] = params[:birthday_date]
    facebook['locale'] = params[:locale]
    facebook['gender'] = "M" if params[:sex] == "male" || params[:sex] == "Male"
    facebook['gender'] = "F" if params[:sex] == "female" || params[:sex] == "Female"
    facebook['facebook_uid'] = params[:facebook_uid]
    facebook['facebook_username'] = params[:facebook_username]
    facebook['facebook_session_key'] = params[:facebook_session_key]
    facebook['facebook_friends_count'] = params[:facebook_friends_count]
    facebook['name'] = facebook['first_name']+" "+facebook['last_name'] if facebook['name'].blank?
    
    if facebook['facebook_uid'].to_i==0 || facebook['facebook_username'].blank? || facebook['facebook_session_key'].blank? || facebook['name'].blank?
      render :text=>"Authantication failed, please send name, facebook uid, facebook username and facebook session key."
      return
    end
    user = User.find_by_facebook_uid(facebook['facebook_uid'])     # User can denying to give the email
    user = User.find_by_email(facebook['email']) if user.nil? && !facebook['email'].blank?
    if user.nil?
      user = User.new(facebook)
      user.save_with_validation(false)
      u = User.find_by_id(user.id)
      u.role_id = 3
      u.activation_code = nil
      u.activated_at = Time.now.utc
      u.save_with_validation(false)      
    else
      user.email = facebook['email']
      user.name = facebook['name']
      user.first_name = facebook['first_name']
      user.last_name = facebook['last_name']
      user.birthday = facebook['birthday']
      user.locale = facebook['locale']
      user.gender = facebook['gender']
      user.facebook_username = facebook['facebook_username']
      user.facebook_session_key = facebook['facebook_session_key']
      user.facebook_friends_count = facebook['facebook_friends_count']
      user.save_with_validation(false)
    end
    api = Api.find_by_user_id(user.id)
    if api.nil?
      api = Api.create(:user_id=>user.id, :key=> Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join ))
    else
      api.update_attribute(:key,Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join ))
    end
    render :text=>api.key
  end

  def search
    keyword = params[:id]
    @search = Sunspot.search(Job) do
      keywords(keyword)
     # with(:coordinates).near(26.4720440, 76.7176280, :precision => 12)
      #facet :location_ids, :multiple => true
    end
    render :text => @search.results.to_json

#    @search.each_hit_with_result do |hit, job|
#
#     end

  end

  def job_list
    unless @api.nil?
      jobs = Job.find_by_user_id(@api.user_id)
      render :text=>jobs.to_json
    else
      render :text=>"Authentication failed."
    end
    
  end

  def create_message
    message_hash = Hash.new
    message_hash['messageable_id'] = params[:messageable_id]
    message_hash['messageable_type'] = params[:messageable_type]
    message_hash['subject'] = params[:subject]
    message_hash['body'] = params[:body]
    message_hash['sender_id'] = @api.user_id
    message_hash['recipient_id'] = params[:recipient_id]

    if message_hash['messageable_id'].to_i > 0 && !message_hash['messageable_type'].blank? && !message_hash['subject'].blank? && !message_hash['body'].blank? && message_hash['sender_id'].to_i>0 && message_hash['recipient_id'].to_i>0
      message = Message.new(message_hash)
      if !message.valid?
        render :text=>"Invalid message."
      else
        message.save
        render :text=>"Message has been sent."
      end
    else
      render :text=>"Invalid message."
    end
  end

  def job
    id = params[:id]
    job = Job.find_by_id(id)
    render :text=>job.to_json
  end

  def facebook_login
    email = params[:email]
    email = params[:email]
    email = params[:email]
    email = params[:email]
    email = params[:email]
  end
  
  def submit_application

  end

  protected

  def check_user
    session_key = params[:session_key]
    @api = Api.find_by_key(session_key)
    if @api.nil?
      render :text=>"Authentication failed."
      return false
    end
  end
  
end
