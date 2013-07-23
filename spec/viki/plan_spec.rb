require 'spec_helper'

describe Viki::Plan, api:true do
  it "fetches payment plans" do
    stub_api 'plans.json', Oj.dump({ 'id' => '1p', 'name' => 'Plan1' })
    described_class.fetch(payment_provider: "stripe") do |response|
      response.value['id'].should eq '1p'
      response.value['name'].should eq 'Plan1'
    end
  end
end

