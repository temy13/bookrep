require 'uri'
require 'net/http'
require 'net/https'
require 'json'
require "koala"

namespace :tmp do
  task :pwa do
    #uri = URI.parse("https://android.googleapis.com/gcm/send")
    uri = URI.parse("https://fcm.googleapis.com/fcm/send")

    request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' =>'application/json', 'Authorization' => 'key=' + ENV["FIREBASE_API_KEY"]})
    request.body = {
      registration_ids: [],
      #to: "cOFWWixifh…LOm6qh54lfaXVFVR__JONjBqnn5lvEzTsSnLRZlwT5QoLmF6k",
      notification: {
        title: "あなたの質問に回答がつきました！",
        body: "ぽyぽよ",
      },
      data:{
        url: ENV["SERVICE_HOST"] + "/questions/10"
      }
    }.to_json

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    http.set_debug_output $stderr

    http.start do |h|
      response = h.request(request)
    end

  end

  task :random_fb => :environment do
    question = Question.offset( rand(Question.count) ).first
    @api = Koala::Facebook::API.new(ENV["FACEBOOK_PAGE_TOKEN"])
    @api.put_wall_post(question.content, {
      #"name" => "投稿ページへのリンクです",
      "link" => question.page_url,
      #"caption" => "新しい質問が投稿されました！",
      #"description" => question.content,
      #"picture" => ENV["SERVICE_HOST"] + question.image.sns.url
    })

  end
end
