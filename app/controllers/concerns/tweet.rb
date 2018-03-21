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

  def get_followers(cursor, count)
    @client = twitter_client
    @client.followers({:cursor => cursor, :count => count})
  end

  def user_search(query, count)
    #@client = twitter_client
    @client = twitter_client
    @client.user_search(query, {:count => count}) #max -> 20
  end

end
