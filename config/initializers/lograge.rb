Rails.application.configure do
  config.lograge.base_controller_class = ['ActionController::API', 'ActionController::Base']

  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Json.new
  config.lograge.custom_options = lambda do |event|
    {
      time: event.time,
      ua: event.payload[:ua],
      exception: event.payload[:exception],
      exception_object: event.payload[:exception_object]
    }
  end

  config.lograge.keep_original_rails_log = true

  config.lograge.logger = ActiveSupport::Logger.new "#{Rails.root}/log/lograge_#{Rails.env}.log"
end
