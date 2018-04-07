require 'uri'
require 'net/http'
require 'net/https'
require 'json'

namespace :tmp do
  task :pwa do
    uri = URI.parse("https://android.googleapis.com/gcm/send")

    request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' =>'application/json', 'Authorization' => 'key=' + ENV["FIREBASE_API_KEY"]})
    request.body = {registration_ids: "cOFWWixifh…LOm6qh54lfaXVFVR__JONjBqnn5lvEzTsSnLRZlwT5QoLmF6k"}.to_json

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    http.set_debug_output $stderr

    http.start do |h|
      response = h.request(request)
      p response
    end

  end
end
