namespace :twitter do
  task :score_and_tweet => :environment do
    p "tweet test"
    #answer score
    Answer.includes(:likes, :book_click_logs).all.each{|answer|
      answer.score = answer.like_count * 2 + answer.book_click_logs.size * 5
      answer.save
    }
    Question.includes(:answers).all.each{|question|
      question.score = question.answers.map{|answer| answer.score + 1}.sum
      question.save
    }
    zeros = Question.where(score: 0)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_KEY"]
      config.consumer_secret = ENV["TWITTER_SECRET"]
      config.access_token = ENV["TWITTER_ACCESS"]
      config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
    end
    question = zeros.shuffle.first
    url = ENV["SERVICE_HOST"] + "/questions/" + question.id.to_s
    @client.update("【注目の質問】" + question.tweet_text + " #ブクリプ　#おすすめの本　" + url)
    p "tweet test done: " + url
  end
end
