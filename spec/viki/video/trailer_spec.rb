require 'spec_helper'

describe Viki::Trailer, api: true do
  before { stub_api 'trailers.json', json_fixture(:trailers), api_version: "v4" }
  it_behaves_like "a video object"
end
