class Membership < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name, :from_date, :until_date, :user_id, :from_year, :until_year
  validates_uniqueness_of :name, :scope => :user_id
  validate :end_date_must_greater_or_equal_with_start_date
  attr_accessor :to_present, :from_year, :until_year

  private

  def end_date_must_greater_or_equal_with_start_date
    if !from_date.blank? and !until_date.blank? and from_date > until_date
      errors.add(:until_date, "must greater or equal with start date!")
    end
  end
end
