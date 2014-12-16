require 'spec_helper'

describe Viki::RecentContribution, api: true do
  it 'fetches recent contributions' do
    stub = stub_request("get", /users\/1u\/recent_contributions.json/)
    described_class.fetch_sync(user_id: "1u")
    stub.should have_been_made
  end
end
