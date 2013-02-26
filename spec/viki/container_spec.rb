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

  it "fetches recommendations for container" do
    resp = stub
    Viki::Container.should_receive(:fetch).with(recommended_for: '50c').and_yield(resp)
    Viki::Container.recommendations('50c') do |res|
      res.should eq resp
    end
  end
end
