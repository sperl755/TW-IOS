require 'test_helper'

class AwardUserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: award_users
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  award_id   :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

