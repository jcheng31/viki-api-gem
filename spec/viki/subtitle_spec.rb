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

   describe "import subtitle" do
    it 'imports a subtitle' do
      stub = stub_request('post', %r{.*/videos/44699v/subtitles/import_srt.json.*})
      described_class.import_srt({video_id: '44699v',content: "srt text",language: 'en'}) do
      end

      Viki.run
      stub.should have_been_made
    end
  end
end

