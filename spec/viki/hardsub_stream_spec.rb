require 'spec_helper'

describe Viki::HardsubStream, api: true do
  it "fetches the list of hardsubs language avaliable" do
    stub_api 'videos/44699v/hardsubs.json', json_fixture(:hardsub_stream_list)
    described_class.fetch(video_id: "44699v") do |response|
      languages = response.value
      languages.keys.should == ['mn','en','id','sv','ro']
    end
  end

  it "fetches a single hardsub stream" do
    stub_api 'videos/44699v/hardsubs/en.json', json_fixture(:hardsub_streams)
    described_class.fetch(video_id: "44699v", language: 'en') do |response|
      steams = response.value
      steams.should be_a_kind_of(Hash)
      steams.keys.should include('144p')
    end
  end
end
