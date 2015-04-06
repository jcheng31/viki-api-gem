require 'spec_helper'

describe Viki::Contributor, api: true do
  it 'fetches contributor\'s info' do
    stub = stub_request("get", /contributors\/1.json/)
    described_class.fetch_sync(id: "1")
    stub.should have_been_made
  end

  it 'updates contributor\'s info' do
    stub = stub_request("put", /contributors\/1.json/)
    described_class.update_sync(id: '1', latest_tutorial_step: 'welcome')
    stub.should have_been_made
  end
end
