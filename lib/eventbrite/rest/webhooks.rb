require 'eventbrite/rest/utils'

module Eventbrite
  module REST
    module Webhooks
      include Eventbrite::REST::Utils

      def webhooks(options = {})
        perform_with_cursor(:get, :v3, "/v3/webhooks/", options, :webhooks, Eventbrite::Webhook)
      end

      def webhook_create(options = {})
        if options[:actions].is_a?(Array)
          options.merge!(actions: options.delete(:actions).join(','))
        end
        perform_with_object(:post, :v3, "/v3/webhooks/", options, Eventbrite::Webhook)
      end

    end
  end
end
