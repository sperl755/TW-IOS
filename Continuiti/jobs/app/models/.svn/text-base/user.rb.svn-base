class User < ActiveRecord::Base
  has_many :companies, :dependent => :destroy
  has_many :access_tokens  
  has_many :company_followers, :foreign_key => :follower_id, :dependent => :destroy
  has_many :following_company, :through => :company_followers, :class_name => "Company",:source => :company, :foreign_key => :company_id, :dependent => :destroy
  has_many :orders
  has_many :locations
  has_many :contracts
  has_many :user_skills, :dependent => :destroy
  has_many :certifications, :dependent => :destroy
  has_many :interests, :dependent => :destroy
  has_many :memberships, :dependent => :destroy
  has_many :endorsements, :dependent => :destroy
  has_many :experiences, :dependent => :destroy
  has_many :educations, :dependent => :destroy
  has_one :user_description, :dependent => :destroy
  has_many :sent_endorsements, :foreign_key => :endorser_id, :class_name => "Endorsement", :dependent => :destroy

  has_many :refered_referrals, :foreign_key => :referrer_id, :class_name => "Referral", :dependent => :destroy
  has_many :referred_users, :class_name => "User", :foreign_key => :referred_id, :through => :refered_referrals, :source => :referred
  has_one :referrer_referrals, :foreign_key => :referred_id, :class_name => "Referral", :dependent => :destroy
  has_one :referrer_user, :class_name => "User", :through => :referrer_referrals, :foreign_key => :referrer_id, :source => :referrer

  has_many :general_availabilities, :dependent => :destroy
 
#  has_many :earnings, :dependent => :destroy

  has_many :paid_to, :foreign_key => :payer_id, :class_name => "Payment"
  has_many :paid_to_jobs, :foreign_key => :payer_id, :class_name => "Payment", :conditions => ["payments.payable_type = ?", "Job"]
  has_many :paid_to_referrers, :foreign_key => :payer_id, :class_name => "Payment", :conditions => ["payments.payable_type = ?", "Referral"]

  has_many :received_from, :foreign_key => :receiver_id, :class_name => "Payment"
  has_many :received_from_jobs, :foreign_key => :receiver_id, :class_name => "Payment", :conditions => ["payments.payable_type = ?", "Job"]
  has_many :received_from_referrals, :foreign_key => :receiver_id, :class_name => "Payment", :conditions => ["payments.payable_type = ?", "Referral"]

  has_many :award_users
  has_many :user_opportunity_preferences
  has_many :user_general_availabilities, :dependent => :destroy

  attr_protected :location_attributes
  ajaxful_rater
  #  validates_presence_of :name
  #validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9A-Z]+\.)+[a-zA-Z]{2,})$/
  validates_associated :user_skills

  #  after_update :save_locations
  def location_attributes=(location_attributes)
    location_attributes.each do |attributes|
      #      locations.build(attributes)
      if attributes[:id].blank?
        self.locations.build(attributes)
      else
        location = locations.detect{ |o| o.id = attributes[:id].to_i}
        location.attributes = attributes
        if location.should_destroy?
          location.destroy
        else
          location.save
        end
      end
    end
  end

  def save_locations
    locations.each do |o|
      if o.should_destroy?
        o.destroy
      else
        o.save(false)
      end

    end
  end

  def self.check_oauth_user(user)
    !user.facebook_uid.blank?
  end

  def self.facebook_details(user,facebook_session_obj)
    unless user.nil? || facebook_session_obj.nil? || facebook_session_obj.user.nil? || facebook_session_obj.user.friends.nil?
      u = User.find_by_id(user.id)
      u.facebook_friends_count = facebook_session_obj.user.friends.count
      u.save_with_validation(false)
    end
  end
  
  def self.update_previous_user(user)
    return user if user.email.nil?
    unless user.email.nil?
      already_exist_user = User.find(:first,:conditions=>['id !=? and email=?',user.id,user.email])
      unless already_exist_user.nil?
        already_exist_user.gender = user.gender if already_exist_user.gender.blank?
        already_exist_user.zip = user.zip if already_exist_user.zip.blank?
        already_exist_user.birthday = user.birthday if already_exist_user.birthday.blank?
        already_exist_user.name = user.name if already_exist_user.name.blank?        
        already_exist_user.	locale = user.locale if already_exist_user.locale.blank?
        already_exist_user.website = user.website if already_exist_user.website.blank?
        already_exist_user.first_name = user.first_name if already_exist_user.first_name.blank?
        already_exist_user.last_name = user.last_name if already_exist_user.last_name.blank?
       
        
        ###### Facebook credentials
        already_exist_user.facebook_uid = user.facebook_uid
        already_exist_user.facebook_username = user.facebook_username
        already_exist_user.facebook_session_key = user.facebook_session_key
        logger.info 'update user - checking facebook connect loop'
        logger.info Time.now.to_s
        #already_exist_user.reset_persistence_token
        already_exist_user.save(false)
        user.delete
        #reset_persistence_token
        return already_exist_user
      end
    end
    return user
  end
  
  def before_connect(facebook_session)
    logger.info 'hello '
    logger.info facebook_session.user.name
    logger.info 'checking facebook connect loop'
    logger.info Time.now.to_s
    self.website = facebook_session.user.website
    self.name = facebook_session.user.name
    self.first_name = facebook_session.user.first_name 
    self.last_name = facebook_session.user.last_name 
    self.birthday = facebook_session.user.birthday_date
    self.locale = facebook_session.user.locale
    gender = "M" if facebook_session.user.sex == "male" || facebook_session.user.sex == "Male"
    gender = "F" if facebook_session.user.sex == "female" || facebook_session.user.sex == "Female"
    self.gender = gender
    #    puts facebook_session.user.status 
    #    puts 	facebook_session.user.political 
    #    puts 	facebook_session.user.pic_small 
    #    puts 	facebook_session.user.quotes 
    #    puts 	facebook_session.user.is_app_user
    #    puts 	facebook_session.user.tv 
    #    puts 	facebook_session.user.profile_update_time 
    #    puts 	facebook_session.user.meeting_sex 
    #    puts 	facebook_session.user.hs_info 
    #    puts 	facebook_session.user.timezone 
    #    puts 	facebook_session.user.relationship_status 
    #    puts 	facebook_session.user.hometown_location 
    #    puts 	facebook_session.user.about_me 
    #    puts 	facebook_session.user.wall_count 
    #    puts 	facebook_session.user.significant_other_id 
    #    puts 	facebook_session.user.pic_big
    #    puts 	facebook_session.user.music 
    #    puts 	facebook_session.user.work_history 
    #    puts 	facebook_session.user.religion 
    #    puts 	facebook_session.user.notes_count 
    #    puts 	facebook_session.user.activities 
    #    puts 	facebook_session.user.pic_square 
    #    puts 	facebook_session.user.movies 
    #    puts 	facebook_session.user.has_added_app 
    #    puts 	facebook_session.user.education_history 
    #    puts 	facebook_session.user.meeting_for 
    #    puts 	
    #    puts 	facebook_session.user.interests 
    #    puts 	facebook_session.user.current_location 
    #    puts 	facebook_session.user.pic 
    #    puts 	facebook_session.user.books 
    #    puts 	facebook_session.user.affiliations 
    #    puts 	facebook_session.user.locale 
    #    puts 	facebook_session.user.profile_url 
    #    puts 	facebook_session.user.proxied_email 
    #    
    #    puts 	facebook_session.user.allowed_restrictions 
    #    puts 	facebook_session.user.pic_with_logo 
    #    puts 	facebook_session.user.pic_big_with_logo 
    #    puts 	facebook_session.user.pic_small_with_logo 
    #    puts 	facebook_session.user.pic_square_with_logo 
    #    puts 	facebook_session.user.online_presence 
    #    puts 	facebook_session.user.verified 
    #    puts 	facebook_session.user.profile_blurb 
    #    puts 	facebook_session.user.is_blocked 
    #    puts 	facebook_session.user.family
    #    puts 	facebook_session.user.uid 
    #    puts 	facebook_session.user.affiliations 
    #    puts 	facebook_session.user.profile_url 
    #    puts 	facebook_session.user.proxied_email
    @fb_email = !facebook_session.user.email.nil? ? facebook_session.user.email : "#{facebook_session.user.first_name}#{facebook_session.user.last_name}"

    self.email = facebook_session.user.email
    self.activated_at = Time.now
    self.activation_code = nil
    
    self.activate
    self.role_id = 3
    #reset_persistence_token
    #self.reset_persistence_token
  end

  def self.update_twitter(user,user_info)
    user.name = user_info['name']
    name = user_info['name'].rpartition(" ")
    user.first_name = name[0]
    user.last_name = name[2]
    user.twitter_friends_count = user_info['friends_count']
    return user
  end

  def self.update_oauth_user(access_token, user_info, oauth_type)
    pp oauth_type
    pp user_info
    user_id = User.user_for_access_token(access_token,oauth_type)
    if !user_id.nil?
      pp "ggggggggggggg"
      user = User.find_by_id(user_id)
      user.twitter_screen_name = user_info['screen_name']
      user = self.update_twitter(user,user_info)
      user.save(false)
    else
      
      user = User.new(:twitter_screen_name=>user_info['screen_name'])
      user = self.update_twitter(user,user_info)
      #user.birthday = Time.now - 20.years
      user.role_id = 3
      user.save_with_validation(false)
      @user = user
      #pp a
      #pp user.errors.full_messages
      access_token = AccessToken.new(:user_id=>user.id,:token=>access_token.token,:secret=>access_token.secret, :oauth_type=>oauth_type)
      access_token.save
    end
    return user
  end

  def self.user_for_access_token(access_token, oauth_type)
    object = AccessToken.find(:first,:conditions=>["token=? and secret=? and oauth_type=?",access_token.token, access_token.secret, oauth_type])
    return object.user_id unless object.nil?
    return nil
  end

  def new_skill_attributes=(skill_attributes)
    skill_attributes.each do |attributes|
      user_skills.build(attributes)
    end
  end

end


# == Schema Information
#
# Table name: users
#
#  id                     :integer(4)      not null, primary key
#  login                  :string(255)
#  email                  :string(255)
#  description            :text
#  avatar_id              :integer(4)
#  crypted_password       :string(255)
#  password_salt          :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  persistence_token      :string(255)
#  stylesheet             :text
#  view_count             :integer(4)      default(0)
#  vendor                 :boolean(1)      default(FALSE)
#  activation_code        :string(40)
#  activated_at           :datetime
#  state_id               :integer(4)
#  metro_area_id          :integer(4)
#  login_slug             :string(255)
#  notify_comments        :boolean(1)      default(TRUE)
#  notify_friend_requests :boolean(1)      default(TRUE)
#  notify_community_news  :boolean(1)      default(TRUE)
#  country_id             :integer(4)
#  featured_writer        :boolean(1)      default(FALSE)
#  last_login_at          :datetime
#  zip                    :string(255)
#  birthday               :date
#  gender                 :string(255)
#  profile_public         :boolean(1)      default(TRUE)
#  activities_count       :integer(4)      default(0)
#  sb_posts_count         :integer(4)      default(0)
#  sb_last_seen_at        :datetime
#  role_id                :integer(4)
#  single_access_token    :string(255)
#  perishable_token       :string(255)
#  login_count            :integer(4)      default(0)
#  failed_login_count     :integer(4)      default(0)
#  last_request_at        :datetime
#  current_login_at       :datetime
#  current_login_ip       :string(255)
#  last_login_ip          :string(255)
#  account_type           :boolean(1)      default(FALSE)
#  rating_average         :decimal(6, 2)   default(0.0)
#  name                   :string(255)
#  facebook_username      :string(255)
#  facebook_uid           :integer(8)
#  locale                 :string(255)
#  website                :string(255)
#  facebook_session_key   :string(255)
#  first_name             :string(55)
#  last_name              :string(55)      not null
#

