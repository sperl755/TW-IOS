class UserSkill < ActiveRecord::Base
  belongs_to :user
  belongs_to :skill
  validates_presence_of :skill_id, :description, :user_id
  validates_uniqueness_of :skill_id, :scope => :user_id
end
