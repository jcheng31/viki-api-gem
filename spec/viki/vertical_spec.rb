require 'spec_helper'

describe Viki::Vertical, api: true do
  describe 'list' do
    it "runs " do
      stub_api "verticals.json", json_fixture(:verticals), {api_version: "v5"}
      described_class.fetch do |response|
        verticals = response.value
        verticals.should be_a_kind_of(Array)
        verticals.first.keys.should include('titles')
        verticals.first.keys.should include('images')
        verticals.first.keys.should include('paywall')
      end
    end
  end

  it "fetches single vertical" do
    stub_api 'verticals/1pv.json', json_fixture(:vertical), {api_version: "v5"}
    described_class.fetch(id: "1pv") do |response|
      vertical = response.value
      vertical.should be_a_kind_of(Hash)
      vertical.keys.should include('titles')
      vertical.keys.should include('images')
    end
  end
end
