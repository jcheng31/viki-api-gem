require 'spec_helper'

describe Viki::SubtitleCompletion, api: true do
  it "fetches a single subtitle" do
    stub_api 'subtitle_completions.json', "SubtitleCompletion", params: {video_ids: "44699v,123v"}
    described_class.fetch(video_ids: "44699v,123v") do |response|
      response.value.should == "SubtitleCompletion"
    end
  end
end
