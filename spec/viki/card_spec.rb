require 'spec_helper'

describe Viki::Card do
  describe 'fetch' do
    it 'should return card' do
      stub_api('users/1u/card.json', Oj.dump({customer_id: 'cus_123', card: {id: '23123c'}}, mode: :compat))
      described_class.fetch_sync(user_id: '1u') do |response|
        res = response.value
        expect(res['customer_id']).to eq 'cus_123'
        expect(res['card']['id']).to eq '23123c'
      end
    end
  end

  describe 'update' do
    it 'should make update call' do
      stub = stub_request('put', %r{.*/users/1u/card.json.*})
            .with(body: Oj.dump({'stripeToken' => 'st333', 'customer_id' => 'cus_123'}))
      described_class.update({ user_id: '1u'}, { 'stripeToken' => 'st333', 'customer_id' => 'cus_123' }) do
      end
      Viki.run
      stub.should have_been_made
    end
  end
end