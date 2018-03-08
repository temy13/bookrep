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

class BookClickLog < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :book, optional: true
  belongs_to :answer

end
