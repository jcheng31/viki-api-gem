require "spec_helper"

describe Viki::ListItem, api: true do
  it 'fetches list items' do
    stub = stub_request('get', %r{.*/v4/lists/1l/items.json.*})
    described_class.fetch({list_id: '1l'}) do
    end
    Viki.run
    stub.should have_been_made
  end

  it 'updates list items' do
    stub = stub_request('put', %r{.*/v4/lists/1l/items.json.*}).with(videos: ['1v', '2v'])
    described_class.update({list_id: '1l'}, {videos: ['1v', '2v']}) do
    end
    Viki.run
    stub.should have_been_made
  end
end
