# == Schema Information
#
# Table name: title_queries
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  query      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class TitleQueryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
