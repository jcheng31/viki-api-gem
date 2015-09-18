require 'spec_helper'

describe Viki::VikiSubscription, api: true do
  describe 'create' do
    it '/users/:user_id/plans/:plan_id.json' do
      stub_api 'users/1u/plans/1p.json', Oj.dump([{'key' => 'value'}]), {api_version: "v5", method: 'post'}
      described_class.create_sync(user_id: '1u', plan_id: '1p') do |response|
        res = response.value.first
        expect(res['key']).to eq 'value'
      end
    end
  end
  describe 'destroy' do
    it '/users/:user_id/plans/:plan_id.json' do
      stub_api 'users/1u/plans/1p.json', Oj.dump([{'key' => 'value'}]), {api_version: "v5", method: 'delete'}
      described_class.destroy_sync(user_id: '1u', plan_id: '1p') do |response|
        res = response.value.first
        expect(res['key']).to eq 'value'
      end
    end
  end
  describe 'subscription_info' do
    it '/users/:user_id/subscription_info.json' do
      stub_api 'users/1u/subscription_info.json', Oj.dump({'key' => 'value'}), {api_version: 'v5', method: 'get'}
      described_class.subscription_info(user_id: '1u') do |response|
        expect(response.value['key']).to eq 'value'
      end
    end
  end
end
