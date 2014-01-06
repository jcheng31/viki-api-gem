require 'spec_helper'

describe Viki::SubtitleCompletion, api: true do
  it "fetches a single subtitle" do
    stub_api 'subtitle_completions.json', '{"en": "90"}', params: {video_ids: "44699v,123v"}
    described_class.fetch(video_ids: "44699v,123v") do |response|
      response.value.should == {"en" => "90"}
    end
  end
end
