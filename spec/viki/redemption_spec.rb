require 'spec_helper'

describe Viki::Redemption, api: true do
  describe 'fetch' do
    it '/users/:user_id/redemptions.json' do
      stub_api 'users/1u/redemptions.json', Oj.dump([{'key' => 'value'}])
      described_class.fetch(user_id: "1u") do |response|
        res = response.value.first
        res["key"].should eq 'value'
      end
    end

    it '/users/:user_id/redemptions/gift_code.json' do
      stub_api 'users/1u/redemptions/XBD.json', Oj.dump({'key' => 'value'})
      described_class.fetch(user_id: '1u', gift_code: 'XBD') do |response|
        res = response.value
        res["key"].should eq 'value'
      end
    end
  end
end