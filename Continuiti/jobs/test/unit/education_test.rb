require 'test_helper'

class EducationTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end




# == Schema Information
#
# Table name: educations
#
#  id           :integer(4)      not null, primary key
#  country      :string(255)
#  organization :string(255)
#  degree_id    :integer(4)
#  major        :string(255)
#  from_year    :integer(4)
#  end_year     :integer(4)
#  description  :text
#  from_date    :date
#  end_date     :date
#  user_id      :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#  url          :string(255)
#  activities   :text
#

