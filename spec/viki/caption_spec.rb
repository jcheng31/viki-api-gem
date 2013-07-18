require 'spec_helper'

describe Viki::Caption, api: true do
  describe "random" do
    it 'returns a caption for given languages' do
      stub = stub_request('get', %r{.*/captions/random.json.*}).with(:query => hash_including({'origin_language' => 'en', 'target_language' => 'ko'}))

      described_class.random(origin_language: 'en', target_language: 'ko') do
      end
      Viki.run
      stub.should have_been_made
    end
  end

  describe "create" do
    it 'create a caption' do
      stub = stub_request('post', %r{.*/captions.json.*})
      described_class.create('origin_subtitle_id' => '1s', 'language' => 'ko', 'content' => 'new caption') do
      end

      Viki.run
      stub.should have_been_made
    end
  end
end
