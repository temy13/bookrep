# == Schema Information
#
# Table name: books
#
#  id              :integer          not null, primary key
#  title           :string
#  isbn10          :string
#  isbn13          :string
#  asin            :string
#  google_books_id :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class BookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
