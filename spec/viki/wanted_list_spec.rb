require 'spec_helper'

describe Viki::WantedList, api: true do
  it 'fetches a list' do
    stub = stub_request('get', %r{.*/v4/wanted_lists/list_name.json.*})
    described_class.fetch({name: 'list_name'}) do
    end
    Viki.run
    stub.should have_been_made
  end
end
