require 'test_helper'

class ApplicationTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end



# == Schema Information
#
# Table name: applications
#
#  id                :integer(4)      not null, primary key
#  job_id            :integer(4)
#  user_id           :integer(4)
#  cover_letter      :text
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer(4)
#  file_updated_at   :datetime
#  status            :integer(1)      default(1)
#  created_at        :datetime
#  updated_at        :datetime
#

