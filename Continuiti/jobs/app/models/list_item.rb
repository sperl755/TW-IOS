class ListItem < ActiveRecord::Base
  belongs_to :list
end

# == Schema Information
#
# Table name: list_items
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  list_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

