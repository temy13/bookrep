Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://' + ENV["REDIS_HOST"] + ':' + ENV["REDIS_PORT"], namespace: "sidekiq" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://' + ENV["REDIS_HOST"] + ':' + ENV["REDIS_PORT"], namespace: "sidekiq" }
end
