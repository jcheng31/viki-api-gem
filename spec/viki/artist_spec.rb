require 'spec_helper'

describe Viki::Artist, api: true do
  before { stub_api 'artists.json', json_fixture(:artists) }
  it_behaves_like "a container object"
end
