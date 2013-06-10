require 'spec_helper'

describe Viki::MusicVideo, api: true do
  before { stub_api 'music_videos.json', json_fixture(:music_videos) }
  it_behaves_like "a video object"
end
