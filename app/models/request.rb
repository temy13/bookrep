# == Schema Information
#
# Table name: requests
#
#  id          :integer          not null, primary key
#  question_id :integer
#  name        :string
#  uid         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#


##name -> screen_name
class Request < ApplicationRecord
  belongs_to :question
end
