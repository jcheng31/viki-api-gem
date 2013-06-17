require 'spec_helper'

describe Viki::Ad, api: true do
  it "fetches ads" do
    stub_api 'videos/44699v/ads.json', json_fixture(:ads)
    described_class.fetch(video_id: "44699v") do |response|
      ads = response.value
      ads.should be_a_kind_of(Array)
    end
  end
end
