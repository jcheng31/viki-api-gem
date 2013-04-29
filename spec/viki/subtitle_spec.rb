require 'spec_helper'

describe Viki::Subtitle, api: true do
  it "fetches a srt format subtitle" do
    stub_api 'videos/44699v/subtitles/en.srt', "SRTSubtitleFile"
    described_class.fetch(video_id: "44699v", language: "en") do |response|
      response.value.should == "SRTSubtitleFile"
    end
  end

  it "fetches a json format subtitle" do
    stub_api 'videos/44699v/subtitles/en.json', "JSONSubtitleFile"
    described_class.fetch(video_id: "44699v", language: "en", format: 'json') do |response|
      response.value.should == "JSONSubtitleFile"
    end
  end
end
