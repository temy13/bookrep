namespace :twitter do
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
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_KEY"]
      config.consumer_secret = ENV["TWITTER_SECRET"]
      config.access_token = ENV["TWITTER_ACCESS"]
      config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
    end
    question = mins.shuffle.first
    url = ENV["SERVICE_HOST"] + "/questions/" + question.id.to_s
    p question
    @client.update("【注目の質問】" + question.tweet_text + " #ブクリプ　#おすすめの本　" + url)
  end
end
