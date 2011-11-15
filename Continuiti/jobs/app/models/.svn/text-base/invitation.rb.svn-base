class Invitation < ActiveRecord::Base
  before_validation :generate_token
  
  def generate_token
    self.token = ::Digest::SHA1.hexdigest([Time.now, self.email_addresses, rand].join)
  end

  def send_invite
    emails = self.email_addresses.split(",").collect{|email| email.strip }.uniq
    emails.each{|email|
      UserNotifier.deliver_signup_invitation(email, self.user, self.message, self.token)
    }
  end
end
