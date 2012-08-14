require 'test_helper'

class BidTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: bids
#
#  id             :integer(4)      not null, primary key
#  job_id         :integer(4)
#  application_id :integer(4)
#  paid_amount    :float
#  fees           :float
#  created_at     :datetime
#  updated_at     :datetime
#

