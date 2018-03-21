class TwitterQuestionWorker include Sidekiq::Worker

  def twitter_client(at, as)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_KEY"]
      config.consumer_secret = ENV["TWITTER_SECRET"]
      config.access_token = at || ENV["TWITTER_ACCESS"]
      config.access_token_secret = as || ENV["TWITTER_ACCESS_SECRET"]
    end
  end

  def official_twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_KEY"]
      config.consumer_secret = ENV["TWITTER_SECRET"]
      config.access_token = ENV["TWITTER_ACCESS"]
      config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
    end
  end

  def tweet_question(question, at, as)
    @client = twitter_client(at, as)
    url = ENV["SERVICE_HOST"] + "/questions/" + question.id.to_s
    @client.update("ブクリプで質問しました! #ブクリプ　" + url)
  end

  def tweet_request(request)
    @client = official_twitter_client
    url = ENV["SERVICE_HOST"] + "/questions/" + request.question_id.to_s
    @client.update("@" + request.name + " おすすめの本を教えて欲しいとリクエストが届いています！" + url)
  end

  def perform(q_id, at, as)
    question = Question.find(q_id)
    tweet_question(question, at, as) if question.is_tweet
    question.requests.each do |r|
     tweet_request(r)
    end
  end



end
