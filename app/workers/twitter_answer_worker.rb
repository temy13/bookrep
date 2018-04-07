class TwitterAnswerWorker include Sidekiq::Worker

  def twitter_client(at, as)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_KEY"]
      config.consumer_secret = ENV["TWITTER_SECRET"]
      config.access_token = at || ENV["TWITTER_ACCESS"]
      config.access_token_secret = as || ENV["TWITTER_ACCESS_SECRET"]
    end
  end

  def perform(a_id, at, as)
    answer = Answer.find(a_id)
    return unless answer.is_tweet
    @client = twitter_client(at, as)
    url = ENV["SERVICE_HOST"] + "/questions/" + answer.question.id.to_s
    @client.update("ブクリプで質問に答えました! " + answer.question.tweet_text + " #ブクリプ　" + url)
  end


end
