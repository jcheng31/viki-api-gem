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

      described_class.send_email({gift_code: 'cool'}, attrs)
      stub.should have_been_made
    end
  end

  describe 'types' do
    it do
      stub_api 'gift_cards/types.json', Oj.dump(
          [
            {
                :id => "5gt",
                :name => "12",
                :payment_provider => "stripe",
                :duration_type => "once",
                :amount_off => 4788,
                :duration_in_months => nil,
                :max_redemptions => 1,
                :price => 2394,
            },
            {
                :id => "6gt",
                :name => "6",
                :payment_provider => "stripe",
                :duration_type => "repeating",
                :amount_off => 399,
                :duration_in_months => 6,
                :max_redemptions => 1,
                :price => 1915
            },
            {
                :id => "7gt",
                :name => "3",
                :payment_provider => "stripe",
                :duration_type => "repeating",
                :amount_off => 399,
                :duration_in_months => 3,
                :max_redemptions => 1,
                :price => 1077
            }
          ], mode: :compat)

      res = described_class.types
      expect(res.value.count).to eq 3
      expect(res.value.map{|gt| gt['name']}).to eq ['12','6','3']
    end
  end

  describe 'generate' do
    it do
      stub = stub_request('post', %r{.*/gift_cards/generate.json.*}).
          with(:body => "{}")
      described_class.generate(gift_type:'3',amount: 3)
      stub.should have_been_made
    end
  end
end