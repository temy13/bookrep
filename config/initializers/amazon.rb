Amazon::Ecs.debug = true
Amazon::Ecs.options = {
  :AWS_access_key_id => ENV["AMAZON_ACCESS_KEY"],
  :AWS_secret_key => ENV["AMAZON_SECRET"],
  :associate_tag => ENV["AMAZON_ASSOCIATE_ID"],
  :country => :jp
}
