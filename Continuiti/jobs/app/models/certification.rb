class Certification < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :title, :award_date, :user_id, :award_year
  validates_uniqueness_of :title, :scope => :user_id
  attr_accessor :award_year
end
