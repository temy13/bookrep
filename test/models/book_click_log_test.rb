# == Schema Information
#
# Table name: book_click_logs
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  answer_id  :integer
#  book_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class BookClickLogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
