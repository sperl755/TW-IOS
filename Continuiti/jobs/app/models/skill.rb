class Skill < ActiveRecord::Base
  has_many :user_skills
end
