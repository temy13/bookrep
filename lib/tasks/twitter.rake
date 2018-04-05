namespace :twitter do

  def official_twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_KEY"]
      config.consumer_secret = ENV["TWITTER_SECRET"]
      config.access_token = ENV["TWITTER_ACCESS"]
      config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
    end
  end

  task :score_and_tweet => :environment do
    #answer score
    Answer.includes(:likes, :book_click_logs).all.each{|answer|
      answer.score = answer.like_count * 2 + answer.book_click_logs.size * 5
      answer.save
    }
    Question.includes(:answers).all.each{|question|
      question.score = question.answers.map{|answer| answer.score + 1}.sum
      question.score += ActionLog.where(path_info: "/questions/" + question.id.to_s).size * 0.1
      question.save
    }
    s = Question.all.order("score").limit(1).offset(5).first.score
    mins = Question.where(score: s)
    question = mins.shuffle.first
    url = ENV["SERVICE_HOST"] + "/questions/" + question.id.to_s
    p question
    @client = official_twitter_client
    @client.update("【注目の質問】" + question.tweet_text + " #ブクリプ　#おすすめの本　\r\n\r\n" + url)
  end


  task :collect_tweets => :environment do
    ids = HashTweet.all.select("tweet_id").map{|t| t.tweet_id}
    @client = official_twitter_client
    tweets = @client.search("#ブクリプ", lang: 'ja', result_type: "recent", exclude: "retweets", count: 100)
     #count = 0
     tweets.take(100).each do |tweet|
       #count += 1
       next if tweet.user.screen_name == "bookreptokyo"
       next if ids.include?(tweet.id)
       user = User.find_by(uid: tweet.user.id)
       HashTweet.create(user_id: user.try(:id), uid:tweet.user.id ,tweet_id: tweet.id, content: tweet.full_text, posted: tweet.created_at)#twitter_id_str: tweet.id_str
     end
  end

  task :collect_users => :environment do
    sname = "bookreptokyo"
    @client = official_twitter_client
    p @client.user(sname)
    p @client.follower_ids(sname).take(10000)
    p @client.friend_ids(sname).take(10000)
    p @client.user_timeline(sname)
  end

end
