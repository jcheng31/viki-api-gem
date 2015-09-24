require "spec_helper"

describe Viki::Image, api: true do
  describe 'update' do
    it 'updates the image' do
      stub_api 'images.json', '[]', method: :put
      stub = stub_request('put', %r{.*/images.json?.*url=145v.*video_id=123v.*})
      described_class.update("video_id" => '123v', "url" => '145v') do |response|
        response.error.should be_nil
      end
      Viki.run
      stub.should have_been_made
    end
  end

  describe 'fetch' do
    it 'fetches the images' do
      stub_api 'images.json', '[]', method: :get
      stub = stub_request('get', %r{.*/images.json?.*video_id=123v})
      described_class.fetch("video_id" => '123v') do |response|
      end
      Viki.run
      stub.should have_been_made
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
