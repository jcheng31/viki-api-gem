require 'spec_helper'

describe Viki::Series, api: true do
  before { stub_api 'series.json', json_fixture(:series), api_version: "v5" }
  it_behaves_like "a container object"
end