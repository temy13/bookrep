# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
#set :output, 'log/crontab.log'

# Rails.rootを使用するために必要
require File.expand_path(File.dirname(__FILE__) + "/environment")
# cronを実行する環境変数
rails_env = ENV['RAILS_ENV'] || :development
# cronを実行する環境変数をセット
set :environment, rails_env
# cronのログの吐き出し場所
set :output, "#{Rails.root}/log/cron.log"



ENV.each { |k, v| env(k, v) }

every 1.hours do
  rake 'rakuten:answer_book_urls'
  rake 'book_add_info:book'
  #rake 'rakuten:all_books_urls'
end

every 1.day do
  rake 'twitter:collect_tweets'
  #rake 'rakuten:all_books_urls'
end


every '0 12,21 * * *' do
  rake 'twitter:score_and_tweet'
end

every '1 0,12 * * *' do
  rake 'amazon:sell'
end
