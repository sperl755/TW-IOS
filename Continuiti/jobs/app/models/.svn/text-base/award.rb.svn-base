class Award < ActiveRecord::Base
  belongs_to :award_type

	#belongs_to :user
	has_many :award_users
  #	validates_presence_of :name, :on => :create, :message => "can't be blank"
  #	validates_uniqueness_of :name, :on => :create
  #	validates_presence_of :level, :on => :create, :message => "can't be blank"
  #	validates_presence_of :description, :on => :create, :message => "can't be blank"
  #	validates_presence_of :award_type_id, :on => :create, :message => "can't be blank"


	validates_presence_of :name, :on => :create
	validates_uniqueness_of :name, :on => :create
	validates_presence_of :level, :on => :create
	validates_presence_of :description, :on => :create
	validates_presence_of :award_type_id, :on => :create
	# Paperclip
	has_attached_file :photo,
	  :styles => {
		:thumb=> "100x100#",
		:small  => "150x150>",
		:medium => "300x300>",
		:large =>   "400x400>" }

  def self.is_friend_email_valid?(friend_emails)
    if friend_emails.strip.blank?
      return false
    else
      split_emails = friend_emails.split(",")
      split_emails.each do |email|
        unless email.strip =~ /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/
          return false
        end
      end
    end
    return true
  end
	
end

# == Schema Information
#
# Table name: awards
#
#  id                 :integer(4)      not null, primary key
#  name               :string(255)
#  level              :integer(4)
#  description        :text
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer(4)
#  created_at         :datetime
#  updated_at         :datetime
#

