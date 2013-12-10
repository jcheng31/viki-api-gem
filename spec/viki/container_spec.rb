require 'spec_helper'

describe Viki::Container, api: true do
  describe 'list' do
    before { stub_api 'containers.json', json_fixture(:containers), api_version: "v5" }
    it_behaves_like "a container object"
  end

  it "fetches single container" do
    stub_api 'containers/1411c.json', json_fixture(:container), api_version: "v5"
    described_class.fetch(id: "1411c") do |response|
      video = response.value
      video.should be_a_kind_of(Hash)
      expect(video.keys).to include('titles')
      expect(video.keys).to include('verticals')
      expect(video.keys).to include('paywall')
    end
    Viki.run
  end

  it "fetches recommendations for container" do
    resp = double
    Viki::Container.should_receive(:fetch).with(recommended_for: '50c').and_yield(resp)
    Viki::Container.recommendations('50c') do |res|
      res.should eq resp
    end
  end

  it "fetches people for container" do
    resp = double
    Viki::Container.should_receive(:fetch).with(people_for: '50c').and_yield(resp)
    Viki::Container.people('50c') do |res|
      res.should eq resp
    end
  end

  it "fetched all containers from a vertical" do
    stub_api 'verticals/1vp/containers.json', json_fixture(:containers), api_version: "v5"
    described_class.fetch(vertical_id: "1vp") do |response|
      containers = response.value
      containers.should be_a_kind_of(Array)
      containers.first.keys.should include 'titles'
    end
  end
end
