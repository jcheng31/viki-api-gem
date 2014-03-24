require 'spec_helper'

describe Viki::Track, api: true do
  describe "index" do
    it "returns all tracks" do
      stub = stub_request('get', %r{.*/v5/tracks.json.*})
      described_class.fetch do
      end
      Viki.run
      stub.should have_been_made
    end
  end
end
