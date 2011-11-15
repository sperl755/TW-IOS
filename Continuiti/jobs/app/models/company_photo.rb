class CompanyPhoto < ActiveRecord::Base
  belongs_to :company

  attr_accessible :company_id
  has_attachment prepare_options_for_attachment_fu(AppConfig.photo['attachment_fu_options'])

#  validates_presence_of :size
#  validates_presence_of :content_type
#  validates_presence_of :filename
#  validates_presence_of :user, :if => Proc.new{|record| record.parent.nil? }
#  validates_inclusion_of :content_type, :in => attachment_options[:content_type], :message => "is not allowed", :allow_nil => true
#  validates_inclusion_of :size, :in => attachment_options[:size], :message => " is too large", :allow_nil => true
end

# == Schema Information
#
# Table name: company_photos
#
#  id           :integer(4)      not null, primary key
#  company_id   :integer(4)
#  content_type :string(255)
#  filename     :string(255)
#  size         :integer(4)
#  parent_id    :integer(4)
#  thumbnail    :string(255)
#  width        :integer(4)
#  height       :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#

