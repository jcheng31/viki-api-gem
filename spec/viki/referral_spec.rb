require 'spec_helper'

describe Viki::Referral do
  it "fetches referrals by user_id" do
    stub_api 'users/1u/referrals.json', Oj.dump({'available_count' => 1, 'used_count' => 1})

    described_class.fetch(user_id: "1u") do |response|
      res = response.value
      res["available_count"].should eq 1
      res["used_count"].should eq 1
    end
  end
end