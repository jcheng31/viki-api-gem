require 'spec_helper'

describe Viki::GiftCard do
  describe 'create' do
    it do
      attrs = { 'purchased_by_id' => '1u',
                'gift_code' => 's123',
                'provider_charge_id' => 't1',
                'payment_provider' => 'stripe',
                'amount' => 10,
                'app_id' => '1000a',
                'design_type' => 'green',
                'message' => 'greetings' }

      stub = stub_request('post', %r{.*/gift_cards.json.*}).
        with(body: Oj.dump(attrs))

      described_class.create({}, attrs) do
      end
      Viki.run
      stub.should have_been_made
    end
  end

  describe 'update' do
    it do
      stub = stub_request('put', %r{.*/gift_cards/x1.json.*})
        .with(body: Oj.dump({'gift_code' => 'x1'}))


      described_class.update({ gift_code: 'x1'}, { 'gift_code' => 'x1' } ) do
      end
      Viki.run
      stub.should have_been_made
    end
  end

  describe 'fetch' do
    it "get gift_card with gift_code" do

      stub_api 'gift_cards/x1.json', Oj.dump({"purchased_by_id" => '5u', "redeemed_by_id" => '7u', "gift_code" => 'x1',
        "design_type" => 'green', "message" => 'message'})

      described_class.fetch(gift_code: 'x1') do |response|
        res = response.value
        res["purchased_by_id"].should eq '5u'
        res["redeemed_by_id"].should eq '7u'
        res["gift_code"].should eq 'x1'
        res["design_type"].should eq 'green'
        res["message"].should eq 'message'
      end
    end
  end

  describe 'send_email' do
    it do
      attrs = { 'recipient_email' => 'coolguy@gmail.com',
                'to' => 'coolgal',
                'from' => 'coolguy',
                'message' => 'sooo coool',
                'month_type' => '12m',
                'is_purchaser' => true }

      stub = stub_request('post', %r{.*/gift_cards/cool/send_email.json.*}).
          with(body: Oj.dump(attrs))

      described_class.send_email({gift_code: 'cool'}, attrs) do
      end
      Viki.run
      stub.should have_been_made
    end
  end
end