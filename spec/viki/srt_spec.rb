require 'spec_helper'

describe Viki::Srt, api: true do
  describe "import subtitle" do
   it 'imports a subtitle' do
      stub = stub_request('post', /.*\/videos\/44699v\/subtitles\/import_srt\.json[^\.]+/)
      described_class.import({video_id: '44699v',content: "srt text",language: 'en'}) do
      end
    Viki.run
    stub.should have_been_made
   end
  end
end