require "spec_helper"

describe Viki::Image, api: true do
  describe 'update' do
    it 'updates the image' do
      stub_api 'images.json', '[]', method: :put
      described_class.update("video_id" => '123v', "url" => '145v') do |response|
        response.error.should be_nil
      end
    end
  end

  describe 'fetch' do
    it 'fetched the images' do
      stub_api 'images.json', '[]', method: :get
      described_class.fetch("video_id" => '123v') do |response|
        response.error.should be_nil
      end
    end
  end

  describe 'create' do
    it 'creates a new image' do
      stub = stub_request('post', %r{.*/images/pr/123pr/poster.json.*}).with(body: {
        file: 'file_data',
        x: 0,
        y: 0,
        source: 'viki'
      })

      described_class.create({path: 'pr', resource_id: '123pr', type: 'poster'}, {
        file: 'file_data',
        x: 0,
        y: 0,
        source: 'viki'
      }) {}
      Viki.run
      stub.should have_been_made
    end
  end
end
