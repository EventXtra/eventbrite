require 'eventbrite/creatable'
require 'eventbrite/identity'

module Eventbrite
  class Webhook < Eventbrite::Identity
    include Eventbrite::Creatable
    include Eventbrite::Changeable

    attr_reader :resource_uri, :endpoint_url, :actions, :user_id, :event_id
  end
end
