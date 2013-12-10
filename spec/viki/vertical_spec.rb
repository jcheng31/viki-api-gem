require 'spec_helper'

describe Viki::Vertical, api: true do
  describe 'list' do
    it "runs " do
      stub_api "verticals.json", json_fixture(:verticals), {api_version: "v5"}
      described_class.fetch do |response|
        verticals = response.value
        expect(verticals).to be_a_kind_of(Array)
        expect(verticals.first.keys).to include('titles')
        expect(verticals.first.keys).to include('images')
        expect(verticals.first.keys).to include('paywall')
      end
    end

    it "should make call to correct path" do
      params = {app: Viki.app_id}
      stub_request("get", "http://api.dev.viki.io/v5/verticals.json")
      .with(query: hash_including(:sig, :t, params),
            :headers => {'Content-Type'=>'application/json', 'User-Agent'=>'viki'})
      .to_return(:status => 200, :body => "[]", :headers => {})
      described_class.fetch do |response|
        expect(response.error).to be_nil
      end
    end
  end

  describe 'single vertical' do
    it "fetches single vertical" do
      stub_api 'verticals/1pv.json', json_fixture(:vertical), {api_version: "v5"}
      described_class.fetch(id: "1pv") do |response|
        vertical = response.value
        expect(vertical).to be_a_kind_of(Hash)
        expect(vertical.keys).to include('titles')
        expect(vertical.keys).to include('images')
      end
    end

    it "should make call to correct path" do
      params = {app: Viki.app_id}
      stub_request("get", "http://api.dev.viki.io/v5/verticals/1vp.json")
      .with(query: hash_including(:sig, :t, params),
            :headers => {'Content-Type'=>'application/json', 'User-Agent'=>'viki'})
      .to_return(:status => 200, :body => "{}", :headers => {})
      described_class.fetch(id: "1vp") do |response|
        expect(response.error).to be_nil
      end
    end
  end

end
