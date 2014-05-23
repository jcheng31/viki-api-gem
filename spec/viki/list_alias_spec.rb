require "spec_helper"

describe Viki::ListAlias, api: true do
  it 'updates an alias for given list' do
    stub = stub_request('post', %r{.*/v4/list_aliases.json.*}).with(list_id: '1l', name: 'alias_for_list1')
    described_class.create({}, {list_id: '1l', name: 'alias_for_list1'}) do
    end
    Viki.run
    stub.should have_been_made
  end
end
