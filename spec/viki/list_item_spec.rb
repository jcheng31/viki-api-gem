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
    stub = stub_request('put', %r{.*/v4/lists/1l/items.json.*}).with(resources: ['1v', '2v'])
    described_class.update({list_id: '1l'}, {resources: ['1v', '2v']}) do
    end
    Viki.run
    stub.should have_been_made
  end

  it 'updates list items with new resources' do
    resources = [{resource_id: '1v', position: 0, country: 'Africa'},
                 {resource_id: '1c', position: 1, country: 'Africa'}]

    stub = stub_request('put', %r{.*/v4/lists/1l/items.json.*}).with(resources: resources)
    described_class.update({list_id: '1l'}, {resources: resources}) do
    end
    Viki.run
    stub.should have_been_made
  end

  it 'patches list items' do
    resources = [{resource_id: '1v', position: 0, country: 'Africa'},
                 {resource_id: '1c', position: 1, country: 'Africa'}]

    stub = stub_request('patch', %r{.*/v4/lists/1l/items.json.*}).with(resources: resources)
    described_class.patch({list_id: '1l'}, {resources: resources}) do
    end
    Viki.run
    stub.should have_been_made
  end

  it "deletes list items"
end
