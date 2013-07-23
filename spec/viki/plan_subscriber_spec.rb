require 'spec_helper'

describe Viki::PlanSubscriber, api: true do
  it "fetches plan subscribers" do
    stub_api 'plan_subscribers.json', Oj.dump([{"id" => "1s", "user_id" => '1u', 'plan_id' => '1p', 'customer_id' => 'customer_1', 'payment_provider' => 'stripe'}])
    described_class.fetch(user_id: "1u") do |response|
      res = response.value.first
      res["id"].should eq '1s'
      res["user_id"].should eq '1u'
      res["customer_id"].should eq 'customer_1'
      res["payment_provider"].should eq 'stripe'
    end
  end
end

