class GeneralAvailability < ActiveRecord::Base
  has_many :user_general_availabilities, :dependent => :destroy
  belongs_to :user

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :user_id, :if => Proc.new { |t| t.respond_to?(:user_id) }
end
