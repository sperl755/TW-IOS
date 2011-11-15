class Industry < ActiveRecord::Base
  has_many :jobs #has_and_belongs_to_many
  
end

# == Schema Information
#
# Table name: industries
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  active     :boolean(1)
#  created_at :datetime
#  updated_at :datetime
#

