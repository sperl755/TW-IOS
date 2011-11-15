class OpportunityPreference < ActiveRecord::Base
  has_many :user_opportunity_preferences
end
