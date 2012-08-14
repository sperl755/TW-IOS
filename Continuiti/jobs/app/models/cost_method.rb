class CostMethod < ActiveRecord::Base
  has_many :jobs

  def self.hourly_method
    self.find(:first,:conditions=>['active=1 and title like ?', "%Hourly%"])
  end
end

# == Schema Information
#
# Table name: cost_methods
#
#  id         :integer(4)      not null, primary key
#  title      :string(255)
#  active     :boolean(1)
#  created_at :datetime
#  updated_at :datetime
#

