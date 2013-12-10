require 'spec_helper'

describe Viki::Artist, api: true do
  before { stub_api 'artists.json', json_fixture(:artists), api_version: "v5"}
  it_behaves_like "a container object"

  context "fetches casts" do
    it do
      stub_api 'artists/129c/casts.json', '["1a", "2a"]', api_version: "v5"
      casts = nil
      described_class.fetch(artist_id: '129c') { |response| casts = response.value }
      Viki.run
      casts.should eq ['1a', '2a']
    end
    it "using the cast_for class method" do
      resp = double
      described_class.should_receive(:fetch).with(artist_id: '129c').and_yield(resp)
      Viki::Artist.casts_for('129c') do |res|
        res.should eq resp
      end
    end
  end
end
