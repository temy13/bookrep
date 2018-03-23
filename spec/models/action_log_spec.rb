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

require 'rails_helper'

RSpec.describe ActionLog, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
