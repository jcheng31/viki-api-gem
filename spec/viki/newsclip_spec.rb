require 'spec_helper'

describe Viki::NewsClip, api:true do
  before { stub_api 'news_clips.json', json_fixture(:news_clips) }
  it_behaves_like "a video object"
end
