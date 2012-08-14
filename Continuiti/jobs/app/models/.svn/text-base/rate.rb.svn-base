class Rate < ActiveRecord::Base
  belongs_to :rater, :class_name => "User"
  belongs_to :rateable, :polymorphic => true
  
  attr_accessible :rate, :dimension

  def self.average_rating(user_id, rateable_id=nil, rateable_type=nil)
    if rateable_id.nil? && rateable_type.nil?
      rate = Rate.find(:first, :conditions=>['rater_id=? and active = true',user_id],:select=>'avg(stars) as avg_rating', :group=>'rater_id')
    else
      rate = Rate.find(:first, :conditions=>['rater_id=? and rateable_id=? and rateable_type=? and active = true',user_id,rateable_id,rateable_type],:select=>'avg(stars) as avg_rating', :group=>'rater_id')
    end
    return avg = rate.nil? ? 0 : rate.avg_rating
  end

  def self.average_type_rating(user_id)
    rate = Rate.find(:all, :joins=>"left join contracts on contracts.id=rates.rateable_id",:conditions=>['(contracts.user_id=? or contracts.contractor_id=?) and rater_id!=? and rateable_type="Contract" and active = true',user_id,user_id,user_id],:select=>'avg(stars) as avg_rating, dimension', :group=>'dimension')
    return rate
  end

  def self.count_rating(user_id, rateable_id, rateable_type)
    count = Rate.count(:conditions=>['rater_id=? and rateable_id=? and rateable_type=?',user_id,rateable_id,rateable_type])
  end
end

# == Schema Information
#
# Table name: rates
#
#  id            :integer(4)      not null, primary key
#  rater_id      :integer(4)
#  rateable_id   :integer(4)
#  rateable_type :string(255)
#  stars         :integer(4)      not null
#  dimension     :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

