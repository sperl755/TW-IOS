class UserOpportunityPreference < ActiveRecord::Base
  belongs_to :user
  belongs_to :opportunity_preference
  validates_uniqueness_of :opportunity_preference_id, :scope => :user_id
end
