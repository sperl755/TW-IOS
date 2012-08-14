class Jobtype < ActiveRecord::Base
  has_many :jobs
end

# == Schema Information
#
# Table name: jobtypes
#
#  id          :integer(4)      not null, primary key
#  title       :string(255)
#  description :string(255)
#  active      :boolean(1)
#  created_at  :datetime
#  updated_at  :datetime
#

