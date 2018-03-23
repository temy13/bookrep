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

FactoryBot.define do
  factory :action_log do
    request_method "MyString"
    user_id 1
    path_info "MyString"
  end
end
