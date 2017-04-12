require 'helper'

describe Eventbrite::Webhook do
  let(:instance) { described_class.new(json_fixture)}
  let(:json_fixture) { fixture_json('webhook.json') }

  it_behaves_like 'creatable'

end
