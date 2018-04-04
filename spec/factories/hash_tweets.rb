# == Schema Information
#
# Table name: hash_tweets
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  uid        :string
#  content    :string
#  posted     :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tweet_id   :integer
#

FactoryBot.define do
  factory :hash_tweet do
    user_id 1
    uid "MyString"
    twitter_id_str "MyString"
    content "MyString"
    posted "2018-04-04 07:56:26"
  end
end
