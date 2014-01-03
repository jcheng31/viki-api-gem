require 'spec_helper'

describe Viki::List, api: true do
  it "fetches single list" do
    stub_api 'lists/1l.json', json_fixture(:list_1l), api_version: "v5"
    described_class.fetch(id: "1l") do |response|
      video = response.value
      video.should be_a_kind_of(Array)
    end
    Viki.run
  end
end
