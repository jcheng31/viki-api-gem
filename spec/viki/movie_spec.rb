require 'spec_helper'

describe Viki::Movie, api: true do
  before { stub_api 'movies.json', json_fixture(:movies) }
  it_behaves_like "a video object"
end
