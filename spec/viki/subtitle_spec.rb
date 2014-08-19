require 'spec_helper'

describe Viki::Subtitle, api: true do
  it "fetches a srt format subtitle" do
    stub_api 'videos/44699v/subtitles/en.srt', '{"data": "some_data"}'
    described_class.fetch(video_id: "44699v", language: "en") do |response|
      response.value.should == {"data" => "some_data"}
    end
  end

  it "fetches a json format subtitle" do
    stub_api 'videos/44699v/subtitles/en.json', '{"data": "some_data"}'
    described_class.fetch(video_id: "44699v", language: "en", format: 'json') do |response|
      response.value.should == {"data" => "some_data"}
    end
  end

end
