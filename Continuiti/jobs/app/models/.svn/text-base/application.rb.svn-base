class Application < ActiveRecord::Base
  belongs_to :job
  belongs_to :user
  has_one :contract
  #has_one :bid, :validate => false
  has_many :messages, :as => :messageable
  
  attr_accessor :terms_of_service
  
  #validates_presence_of  :cover_letter
  validates_numericality_of :fixed_cost_amount, :allow_blank => false, :message=>' is not valid', :unless => Proc.new { |application| application.job.fixed_cost_amount.nil?}
  validates_numericality_of :hourly_rate, :allow_blank => false, :message=>' is not valid', :unless => Proc.new { |application| application.job.hourly_rate.nil?}
  validates_numericality_of :annual_salary, :allow_blank => false, :message=>' is not valid', :unless => Proc.new { |application| application.job.annual_salary.nil?}
  validates_presence_of :start_date
  
  has_attached_file :file, :path => ":rails_root/public/system/applications/:id/:basename.:extension",
                      :url => "/system/applications/:id/:basename.:extension"
  validates_attachment_size :file, :less_than => 2.megabytes
  validates_acceptance_of :terms_of_service

  def self.application_count(job_id, application_status_id)
    Application.count(:conditions=>['job_id=? and status=?', job_id, application_status_id])
  end

   # Message will be to either job owner or applicant who is not logged in
  def self.get_message_to(application, login_user_id)
    if application.user_id == login_user_id
      return application.job.user
    else
      return application.user
    end
  end
end



# == Schema Information
#
# Table name: applications
#
#  id                :integer(4)      not null, primary key
#  job_id            :integer(4)
#  user_id           :integer(4)
#  cover_letter      :text
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer(4)
#  file_updated_at   :datetime
#  status            :integer(1)      default(1)
#  created_at        :datetime
#  updated_at        :datetime
#

