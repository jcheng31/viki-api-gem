require 'spec_helper'

describe Viki::Stream, api: true do
  it "fetches a single stream" do
    stub_api 'videos/44699v/streams.json', json_fixture(:streams)
    described_class.fetch(video_id: "44699v") do |response|
      steams = response.value
      steams.should be_a_kind_of(Hash)
      steams.keys.should include('240p')
    end
  end
end
