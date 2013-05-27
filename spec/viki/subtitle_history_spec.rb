require 'spec_helper'

describe Viki::SubtitleHistory, api: true do
  it 'fetches subtitle histories' do
    stub = stub_request("get", /users\/1u\/subtitle_histories.json/)
    described_class.fetch_sync(user_id: "1u")
    stub.should have_been_made
  end
end
