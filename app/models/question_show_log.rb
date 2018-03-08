# == Schema Information
#
# Table name: question_show_logs
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class QuestionShowLog < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :question
end
