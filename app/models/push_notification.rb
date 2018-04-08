# == Schema Information
#
# Table name: push_notifications
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  is_notice      :boolean          default(TRUE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  endpoint       :string
#  p256dh         :string
#  auth           :string
#  firebase_token :string
#

class PushNotification < ApplicationRecord
  belongs_to :user

  def answer_notice(q_id)
    q = Question.find(q_id)
    #uri = URI.parse("https://android.googleapis.com/gcm/send")
    uri = URI.parse("https://fcm.googleapis.com/fcm/send")

    request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' =>'application/json', 'Authorization' => 'key=' + ENV["FIREBASE_API_KEY"]})
    request.body = {
      registration_ids: [firebase_token],
      #to: "cOFWWixifh…LOm6qh54lfaXVFVR__JONjBqnn5lvEzTsSnLRZlwT5QoLmF6k",
      notification: {
        title: "あなたの質問に回答がつきました！",
        body: q.tweet_text(10),
      },
      data:{
        url: q.page_url
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
end
