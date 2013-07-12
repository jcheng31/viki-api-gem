require 'spec_helper'

describe Viki::Translation, api: true do
  describe "random" do
    it 'returns subtitles for each languages' do
      stub = stub_request('get', %r{.*/translations/random.json.*}).with(:query => hash_including({'origin_language' => 'en', 'target_language' => 'ko'}))

      described_class.random(origin_language: 'en', target_language: 'ko') do
      end
      Viki.run
      stub.should have_been_made
    end
  end

  describe "rating" do
    it 'likes a subtitle content if like is true' do
      stub = stub_request('post', %r{.*/translations/1s/like.json.*}).with(:query => hash_including({'origin_subtitle_id' => '2s'}))

      described_class.rating(origin_subtitle_id: '2s', target_subtitle_id: '1s', like: true) do
      end
      Viki.run
      stub.should have_been_made
    end

    it 'dislikes a subtitle content if like is false' do
      stub = stub_request('post', %r{.*/translations/1s/dislike.json.*}).with(:query => hash_including({'origin_subtitle_id' => '2s', suggested_content: 'better content'}))

      described_class.rating(origin_subtitle_id: '2s', target_subtitle_id: '1s', like: false, suggested_content: 'better content') do
      end
      Viki.run
      stub.should have_been_made
    end
  end

  describe "report" do
    it 'reports a subtitle as a spam' do
      stub = stub_request('post', %r{.*/translations/1s/report.json.*})
      described_class.report(subtitle_id: '1s') do
      end

      Viki.run
      stub.should have_been_made
    end
  end
end
