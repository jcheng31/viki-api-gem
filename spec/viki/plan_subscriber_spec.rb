require 'spec_helper'

describe Viki::PlanSubscriber, api: true do
  it "fetches plan subscribers by user_id and plan_id" do
    stub_api 'users/1u/plans/1p.json', Oj.dump([{"id" => "1s", "user_id" => '1u', 'plan_id' => '1p', 'customer_id' => 'customer_1', 'payment_provider' => 'stripe'}])
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

  it "fetches plan subscribers by payment_provider" do
    stub_api 'plan_subscribers.json', Oj.dump([{ "id" => "1s", "user_id" => '1u', 'plan_id' => '1p', 'customer_id' => 'customer_1', 'payment_provider' => 'stripe' }])
    described_class.fetch(payment_provider: "stripe") do |response|
      res = response.value.first
      res["id"].should eq '1s'
      res["user_id"].should eq '1u'
      res["customer_id"].should eq 'customer_1'
      res["payment_provider"].should eq 'stripe'
    end
  end
end

