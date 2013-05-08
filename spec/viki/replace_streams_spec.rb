require "spec_helper"

describe Viki::ReplaceStream, api: true do
  describe 'update' do
    it 'replaces the streams' do
      stub_api 'replace_streams.json', '[]', method: :put
      described_class.update("old_video_id" => '123v', "new_video_id" => '145v') do |response|
        response.error.should be_nil
      end
    end
  end
end
