require 'spec_helper'

describe Viki::EncodingPreset, api: true do
  it "fetches a encoding presets" do
    stub_api 'encoding_presets.json', json_fixture(:encoding_presets) , {:params => {video_id: '1v'}}
    described_class.fetch(video_id: "1v") do |response|
      jobs = response.value
      jobs.should be_a_kind_of(Array)
    end
  end
end
