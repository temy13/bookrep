module Tweet extend ActiveSupport::Concern

  def twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_KEY"]
      config.consumer_secret = ENV["TWITTER_SECRET"]
      config.access_token = session[:access_token] || ENV["TWITTER_ACCESS"]
      config.access_token_secret = session[:access_token_secret] || ENV["TWITTER_ACCESS_SECRET"]
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

  def tweet_question(question)
    @client = twitter_client
    url = "https://nextbooks.herokuapp.com/questions/" + question.id.to_s
    @client.update("ブクリプで質問しました! " + url)
  end

  def tweet_answer(answer)
    @client = twitter_client
    url = "https://nextbooks.herokuapp.com/questions/" + answer.question.id.to_s
    @client.update("ブクリプで質問に答えました! " + url)
  end

  def get_followers(cursor, count)
    @client = twitter_client
    @client.followers({:cursor => cursor, :count => count})
  end

  def user_search(query, count)
    #@client = twitter_client
    @client = twitter_client
    @client.user_search(query, {:count => count})
  end

  def tweet_request(request)
    @client = official_twitter_client
    url = "https://nextbooks.herokuapp.com/questions/" + request.question_id.to_s
    @client.update("@" + request.name + " リクエストが届いています！ " + url)
  end

end
