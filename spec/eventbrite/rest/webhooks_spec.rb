describe Eventbrite::REST::Webhooks do
  let(:client) { Eventbrite::REST::Client.new(oauth_token:"TOKEN") }

  describe '.webhooks' do
    subject { client.webhooks }

    before do
      stub_get('/v3/webhooks/').
        with(:query => {page:1}).
        to_return(
          :body => fixture('webhooks.json'),
          :headers => {:content_type => 'application/json; charset=utf-8'}
        )
    end

    it_behaves_like 'a cursor'
    it { subject; expect(a_get('/v3/webhooks/').with(:query => {page:1})).to have_been_made }
    its(:first) { should be_a_kind_of(Eventbrite::Webhook) }
  end

  describe '.webhook_create' do
    subject { client.webhook_create(webhook_params) }

    let(:webhook_params) {
      {
        endpoint_url: 'https://123.com/123',
        actions: ['attendee.updated'],
        event_id: '16531748906',
        page: "1"
      }
    }

    before do
      stub_params = webhook_params.merge(actions: webhook_params[:actions].join(','))
      stub_post('/v3/webhooks/').
        with(body: stub_params).
        to_return(
          :body => fixture('webhook_create.json'),
          :headers => {:content_type => 'application/json; charset=utf-8'}
        )
    end

    it { subject; expect(a_post('/v3/webhooks/')).to have_been_made }
    it { should be_a_kind_of(Eventbrite::Webhook) }
    its("resource_uri") { should eq('https://www.eventbriteapi.com/v3/webhooks/369708/') }
    its("endpoint_url") { should eq("https://123.com/123") }
    its("actions") { should match_array(['attendee.updated']) }
    its("user_id") { should eq('23217496728') }
    its("event_id") { should eq('16531748906') }
  end
end
