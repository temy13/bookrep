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

FactoryBot.define do
  factory :twitter_user do
    user_id 1
    tweets "MyString"
    followers_count 1
    friends_count 1
    favolites_count 1
    description "MyString"
    screen_name "MyString"
    uid "MyString"
    last_tweet "2018-04-04 07:34:49"
    get_friends false
  end
end
