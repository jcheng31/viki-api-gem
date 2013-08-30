require 'spec_helper'

describe Viki::PlanSubscriber, api: true do
  describe "fetcher" do
    it "fetches plan subscribers by user_id and plan_id" do
      stub_api 'users/1u/plans/1p.json', Oj.dump([{ "id" => "1s", "user_id" => '1u', 'plan_id' => '1p', 'customer_id' => 'customer_1', 'payment_provider' => 'stripe' }])
      described_class.fetch(user_id: "1u", plan_id: "1p") do |response|
        res = response.value.first
        res["id"].should eq '1s'
        res["user_id"].should eq '1u'
        res["customer_id"].should eq 'customer_1'
        res["payment_provider"].should eq 'stripe'
      end
    end

    it "fetches plan subscribers by user_id" do
      stub_api 'users/1u/plans.json', Oj.dump([{ "id" => "1s", "user_id" => '1u', 'plan_id' => '1p', 'customer_id' => 'customer_1', 'payment_provider' => 'stripe' }])
      described_class.fetch(user_id: "1u") do |response|
        res = response.value.first
        res["id"].should eq '1s'
        res["user_id"].should eq '1u'
        res["customer_id"].should eq 'customer_1'
        res["payment_provider"].should eq 'stripe'
      end
    end
  end

  describe 'create' do
    it do
      stub = stub_request('post', %r{.*/users/1u/plans/1p.json.*}).
        with(body: Oj.dump({ 'customer_id' => "cus1" }))

      described_class.create({ user_id: "1u", plan_id: "1p" }, { 'customer_id' => "cus1" }) do
      end
      Viki.run
      stub.should have_been_made
    end
  end

  describe 'destroy' do
    it "deletes plan_subscriber" do
      stub = stub_request('delete', %r{.*/users/1u/plans/1p.json.*})

      described_class.destroy({ user_id: "1u", plan_id: "1p" }) do; end
      Viki.run
      stub.should have_been_made
    end
  end

  describe 'update' do
    it 'updates' do
      stub = stub_request('put', %r{.*/users/1u/plans/1p.json.*})
        .with(body: Oj.dump({'active' => true}))


      described_class.update({ user_id: '1u', plan_id: '1p'}, { 'active' => true } ) do
      end
      Viki.run
      stub.should have_been_made
    end
  end
end

