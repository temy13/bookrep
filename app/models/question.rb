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

class Question < ApplicationRecord
  include QAModule

  belongs_to :user
  has_many :answers
  has_many :requests
  has_many :question_show_logs

  accepts_nested_attributes_for :requests
  validates :content, presence: true

  mount_uploader :image, ImageUploader

  scope :answered, -> {
    answer_table = Answer.arel_table
    condition = Answer.where( answer_table[:question_id].eq( arel_table[:id] ) )
    where( condition.exists )
  }

  scope :not_answered, -> {
    answer_table = Answer.arel_table
    condition = Answer.where( answer_table[:question_id].eq( arel_table[:id] ) )
    where( condition.exists.not )
  }

  scope :user_questions, -> user_id {
    where(user_id: user_id)
  }

  scope :user_answered, -> user_id {
    joins(:answers).where('answers.user_id = ?', user_id)
  }

  scope :user_questions_remove_anonymous, -> user_id{
    where(user_id: user_id, is_anonymous: false)
  }

  scope :user_answered_remove_anonymous, -> user_id {
    joins(:answers).where('answers.user_id = ? and answers.is_anonymous = false', user_id)
  }




end
