Rails.application.configure do
  config.lograge.base_controller_class = ['ActionController::API', 'ActionController::Base']

  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Json.new
  config.lograge.custom_options = lambda do |event|
    exceptions = %w(controller action format authenticity_token)
    {
      time: event.time,
      ua: event.payload[:ua],
      params: event.payload[:params].except(*exceptions),
      login_id: event.payload[:login_id],
      ip: event.payload[:ip],
      remote_ip: event.payload[:remote_ip],
      referer: event.payload[:referer],
      exception: event.payload[:exception],
      exception_object: event.payload[:exception_object],
      exception_backtrace: event.payload[:exception_object].present? ? "" : event.payload[:exception_object].backtrace[0..6]
    }
  end

  config.lograge.keep_original_rails_log = true

  config.lograge.logger = ActiveSupport::Logger.new "#{Rails.root}/log/lograge_#{Rails.env}.log"
end
