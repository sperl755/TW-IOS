class CompanyFollower < ActiveRecord::Base
  belongs_to :company
  belongs_to :follower, :class_name => 'User'
  validates_uniqueness_of :follower_id, :scope => :company_id
end

# == Schema Information
#
# Table name: company_followers
#
#  id          :integer(4)      not null, primary key
#  company_id  :integer(4)
#  follower_id :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

