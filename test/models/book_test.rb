# == Schema Information
#
# Table name: books
#
#  id                    :integer          not null, primary key
#  title                 :string
#  isbn10                :string
#  isbn13                :string
#  asin                  :string
#  google_books_id       :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  subtitle              :string
#  google_categories     :string
#  rakuten_affiliate_url :string
#  google_description    :string
#  vector_json           :string
#

require 'test_helper'

class BookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
