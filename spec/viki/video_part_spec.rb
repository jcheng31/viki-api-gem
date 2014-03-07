require 'spec_helper'

describe Viki::VideoPart, api: true do
  describe "index" do
    it "returns video parts for the video" do
      stub = stub_request('get', %r{.*videos/123v/video_parts.json.*})
      described_class.fetch(video_id: '123v') do
      end
      Viki.run
      stub.should have_been_made
    end
  end

  describe "create" do
    it "create video parts via videos/:video_id/video_parts" do
      stub = stub_request('post', %r{.*videos/123v/video_parts.json.*})
      described_class.create(video_id: '123v', end_times: [60000, 120000]) do
      end
      Viki.run
      stub.should have_been_made
    end
  end
end
