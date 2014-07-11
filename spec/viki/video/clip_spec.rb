require 'spec_helper'

describe Viki::Clip, api: true do
  before { stub_api 'clips.json', json_fixture(:clips), api_version: "v4" }
  it_behaves_like "a video object"
end
