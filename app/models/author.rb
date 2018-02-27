# == Schema Information
#
# Table name: authors
#
#  id         :integer          not null, primary key
#  book_id    :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Author < ApplicationRecord
  belongs_to :book
end
