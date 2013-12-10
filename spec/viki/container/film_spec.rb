require 'spec_helper'

describe Viki::Film, api: true do
  before { stub_api 'films.json', json_fixture(:films), api_version: "v5" }
  it_behaves_like "a container object"
end
