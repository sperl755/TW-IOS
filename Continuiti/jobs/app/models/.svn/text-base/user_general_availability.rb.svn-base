class UserGeneralAvailability < ActiveRecord::Base
  belongs_to :user
  belongs_to :general_availability
  validates_uniqueness_of :general_availability_id, :scope => :user_id
end
