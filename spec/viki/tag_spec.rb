require 'spec_helper'

describe Viki::Tag, api: true do
  describe "tags" do
    it "returns a list of tags" do
      stub = stub_request('get', %r{.*/tags.json.*})

      described_class.fetch(tag_type: 'external') do
      end
      Viki.run
      stub.should have_been_made
    end
  end

  describe "fetch a single tag ID" do
    it "returns a single tag information" do
      stub = stub_request('get', %r{.*/tags/37t.json.*})

      described_class.fetch(id: '37t', tag_type: 'external') do
      end
      Viki.run
      stub.should have_been_made
    end
  end

  describe "fetch tag language" do
    it "returns languages of a particular tag" do
      stub = stub_request('get', %r{.*/tags/37t/languages.json.*})

      described_class.tags_languages(id: '37t') do
      end
      Viki.run
      stub.should have_been_made
    end
  end

  describe "fetch resource's tags" do
    it "returns all tags of a particular resource" do
      stub = stub_request('get', %r{.*/movies/tags.json.*})

      described_class.fetch(resource: 'movies', tag_type: 'external') do
      end
      Viki.run
      stub.should have_been_made
    end
  end

  describe "fetch container's tags" do
    it "returns all tags of a particular container" do
      stub = stub_request('get', %r{.*/series/50c/tags.json.*})

      described_class.fetch(resource: 'series', id: '50c', tag_type: 'external') do
      end
      Viki.run
      stub.should have_been_made
    end
  end
end
