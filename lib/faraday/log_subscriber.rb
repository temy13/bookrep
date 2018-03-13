module Faraday
  class LogSubscriber < ActiveSupport::LogSubscriber
    class << self
      def runtime=(value)
        Faraday::RuntimeRegistry.api_runtime = value
      end

      def runtime
        Faraday::RuntimeRegistry.api_runtime ||= 0
      end

      def reset_runtime
        rt, self.runtime = runtime, 0
        rt
      end
    end

    def request(event)
      self.class.runtime += event.duration
      return unless logger.debug?+

      env = event.payload

      method = env[:method].to_s.upcase
      status = env[:status]
      request = env[:url]

      debug " #{method} #{status} #{request} (#{duration_color(event.duration)}) "
    end
    private

      def duration_color(payload_duration)
        display_duration = "%.1fms" % payload_duration
        display_color    = payload_duration >= 1500 ? RED : GREEN
        color(display_duration, display_color, true)
      end
  end
end

Faraday::LogSubscriber.attach_to :faraday
