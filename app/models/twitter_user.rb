# == Schema Information
#
# Table name: twitter_users
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  tweets          :string
#  followers_count :integer
#  friends_count   :integer
#  favolites_count :integer
#  description     :string
#  screen_name     :string
#  uid             :string
#  last_tweet      :datetime
#  get_friends     :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  is_follow       :boolean          default(FALSE)
#  share_count     :integer          default(0)
#

#リクエスト推薦用データ
class TwitterUser < ApplicationRecord
end
