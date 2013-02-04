require 'spec_helper'

describe Viki::Clip, api: true do
  before { stub_api 'clips.json', json_fixture(:clips) }
  it_behaves_like "a video object"
end
