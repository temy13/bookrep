# == Schema Information
#
# Table name: push_notifications
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  is_notice      :boolean          default(TRUE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  endpoint       :string
#  p256dh         :string
#  auth           :string
#  firebase_token :string
#

FactoryBot.define do
  factory :push_notification do
    user_id 1
    Endpoint "MyString"
    is_notice false
  end
end
