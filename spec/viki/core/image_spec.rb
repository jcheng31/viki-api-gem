require "spec_helper"

describe Viki::Image, api: true do
  describe 'update' do
    it 'updates the image' do
      stub_api 'image.json', '[]', method: :put
      described_class.update("video_id" => '123v', "url" => '145v') do |response|
        response.error.should be_nil
      end
    end
  end

    describe 'fetch' do
    it 'fetched the images' do
      stub_api 'image.json', '[]', method: :get
      described_class.fetch("video_id" => '123v') do |response|
        response.error.should be_nil
      end
    end
  end
end
