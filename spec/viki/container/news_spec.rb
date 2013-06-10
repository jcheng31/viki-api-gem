require 'spec_helper'

describe Viki::News, api: true do
  before { stub_api 'news.json', json_fixture(:news) }
  it_behaves_like "a container object"
end
