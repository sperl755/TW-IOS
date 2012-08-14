class AwardType < ActiveRecord::Base
  has_many :awards, :dependent => :destroy
  validates_presence_of :name
  validates_uniqueness_of :name
end
