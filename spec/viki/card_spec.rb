require 'spec_helper'

describe Viki::Card do
  describe 'fetch' do
    it 'should return card' do
      stub_api('cards/card_123.json', Oj.dump({customer_id: 'cus_123', card: {id: '23123c'}}, mode: :compat))
      described_class.fetch_sync(id: 'card_123') do |response|
        res = response.value
        expect(res['customer_id']).to eq 'cus_123'
        expect(res['card']['id']).to eq '23123c'
      end
    end
  end

  describe 'update' do
    it 'should make update call' do
      stub = stub_request('put', %r{.*/cards/card_123.json.*})
      described_class.update({ id: 'card_123'}) do
      end
      Viki.run
      stub.should have_been_made
    end
  end
end