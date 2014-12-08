require 'spec_helper'

describe Viki::RecentActivity, api: true do
  it 'fetches recent activities' do
    stub = stub_request("get", /users\/1u\/recent_activities.json/)
    described_class.fetch_sync(user_id: "1u")
    stub.should have_been_made
  end
end
