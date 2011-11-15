class ExperienceLevel < ActiveRecord::Base
  belongs_to :experiences, :foreign_key => :career_level_id 
end

# == Schema Information
#
# Table name: experience_levels
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

