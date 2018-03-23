# == Schema Information
#
# Table name: action_logs
#
#  id             :integer          not null, primary key
#  request_method :string
#  user_id        :integer
#  path_info      :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  remote_ip      :string
#  ip             :string
#

class ActionLog < ApplicationRecord
  belongs_to :user, optional: true
end
