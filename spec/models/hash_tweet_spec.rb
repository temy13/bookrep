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

require 'rails_helper'

RSpec.describe HashTweet, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
