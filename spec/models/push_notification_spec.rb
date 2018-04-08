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

require 'rails_helper'

RSpec.describe PushNotification, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
