require 'spec_helper'

describe Viki::Subtitle, api: true do
  it "fetches a single subtitle" do
    stub_api 'videos/44699v/subtitles/en.srt', "SubtitleFile"
    described_class.fetch(video_id: "44699v", language: "en") do |response|
      response.value.should == "SubtitleFile"
    end
  end
end
