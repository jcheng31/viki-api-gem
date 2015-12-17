require 'spec_helper'

describe Viki::RelatedNews, api: true do
  it "fetches related news with resource type and id" do
    stub_api 'people/15203pr/related_news.json', json_fixture(:related_news)
    described_class.fetch(resource_type: "people", resource_id: "15203pr", src: "soompi", language: "en") do |response|
      response.value['news_items'].should be_a_kind_of(Array)
    end
  end

  it "fetches all related news without resource type and id" do
    stub_api 'related_news.json', json_fixture(:related_news)
    described_class.fetch(src: "soompi", language: "en", news_type: "spotlight") do |response|
      response.value['news_items'].should be_a_kind_of(Array)
    end
  end
end
