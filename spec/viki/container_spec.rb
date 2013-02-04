require 'spec_helper'

describe Viki::Container, api: true do
  describe 'list' do
    before { stub_api 'containers.json', json_fixture(:containers) }
    it_behaves_like "a container object"
  end

  it "fetches single container" do
    stub_api 'containers/1411c.json', json_fixture(:container)
    described_class.fetch(id: "1411c") do |response|
      video = response.value
      video.should be_a_kind_of(Hash)
      video.keys.should include('titles')
    end
    Viki.run
  end
end
