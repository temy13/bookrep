# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  answer_id  :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  like       :boolean          default(FALSE), not null
#

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :answer
  scope :liked, -> { where(like: true) }
  #validates :user_id,  uniquness: { scope: [:answer_id]  }
  # validates_uniqueness_of :user_id, :answer_id

end
