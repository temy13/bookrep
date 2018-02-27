# == Schema Information
#
# Table name: requests
#
#  id          :integer          not null, primary key
#  question_id :integer
#  name        :string
#  uid         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
