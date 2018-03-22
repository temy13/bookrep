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
#

require 'rails_helper'
require 'support/factory_bot'

describe Book do
  #auto_complete_map
  #new_book
  #new_authors
  #affiliate_url
  #image_url
  #authors_txt
end
