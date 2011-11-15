require 'resolv'
class Endorsement < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :description, :job_title, :company_name, :relation_type, :years_relation, :endorser_id, :user_id

  def self.is_message_and_friend_email_valid?(message_subject, message, friend_emails)
    if message_subject.strip.blank? and message.strip.blank? and friend_emails.strip.blank?
      return [false, "Message's subject, message and friend's emails can't be blank"]
    elsif message_subject.strip.blank?
      return [false, "Message's subject can't be blank"]
    elsif message.strip.blank?
      return [false, "Message can't be blank"]
    elsif friend_emails.strip.blank?
      return [false, "Friend emails can't be blank"]
    else
      split_emails = friend_emails.split(",")
      split_emails.each do |email|
        unless email.strip =~ /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/
          return [false, "Your email address does not appear to be valid"]
          #        else
          #          return [false, "Your email domain name appears to be incorrect"] unless validate_email_domain(email.strip)
        end
      end
    end
    return [true, "All fields valid"]
  end

  def self.validate_email_domain(email)
    domain = email.match(/\@(.+)/)[1]
    Resolv::DNS.open do |dns|
      @mx = dns.getresources(domain, Resolv::DNS::Resource::IN::MX)
    end
    @mx.size > 0 ? true : false
  end
end
