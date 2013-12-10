require 'spec_helper'

describe Viki::Episode, api: true do
  before { stub_api 'episodes.json', json_fixture(:episodes), api_version: "v5" }
  it_behaves_like "a video object"
end
