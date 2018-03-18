# == Schema Information
#
# Table name: questions
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  content      :string           not null
#  is_anonymous :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  is_tweet     :boolean          default(FALSE)
#  image        :string
#  score        :integer          default(0)
#

require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
