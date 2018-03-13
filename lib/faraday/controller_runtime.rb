module Faraday
  module ControllerRuntime
    extend ActiveSupport::Concern

    protected

    attr_internal :faraday_runtime

    def process_action(action, *args)
      Faraday::LogSubscriber.reset_runtime
      super
    end

    def append_info_to_payload(payload)
      super
      payload[:faraday_runtime] = (faraday_runtime || 0) + Faraday::LogSubscriber.reset_runtime
    end

    module ClassMethods
      def log_process_action(payload)
        messages, faraday_runtime = super, payload[:faraday_runtime]
        messages << ("Faraday: %.1fms" % faraday_runtime.to_f) if faraday_runtime
        messages
      end
    end
  end
end

ActiveSupport.on_load(:action_controller) do
  include Faraday::ControllerRuntime
end
