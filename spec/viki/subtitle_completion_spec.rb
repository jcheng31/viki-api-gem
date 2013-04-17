require 'spec_helper'

describe Viki::SubtitleCompletion, api: true do
  it "fetches a single subtitle" do
    stub_api 'videos/44699v/subtitle_completions.json', "SubtitleCompletion"
    described_class.fetch(video_id: "44699v") do |response|
      response.value.should == "SubtitleCompletion"
    end
  end
end
