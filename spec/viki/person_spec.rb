require 'spec_helper'

describe Viki::Person, api: true do
  describe "index" do
    it "returns a list of people" do
      stub = stub_request('get', %r{.*/people/es.json.*})

      described_class.fetch(language: 'es') do
      end
      Viki.run
      stub.should have_been_made
    end
  end

  describe "create" do

    it "creates a person" do
      stub = stub_request('post', %r{.*/people.json.*}).with(body: {name: 'person name'})

      described_class.create({}, {name: 'person name'}) do
      end
      Viki.run
      stub.should have_been_made
    end
  end

  describe "fetch one person" do
    it "returns a person information in the selected language" do
      stub = stub_request('get', %r{.*/people/42pr/es.json.*})

      described_class.fetch(person_id: '42pr', language: 'es') do
      end
      Viki.run
      stub.should have_been_made
    end
  end

  describe "fetch languages of a person" do
    it "returns a person languages meta information" do
      stub = stub_request('get', %r{.*/people/42pr/languages.json.*})

      described_class.languages(person_id: '42pr') do
      end
      Viki.run
      stub.should have_been_made
    end
  end

  describe "fetch languages mata information of a person" do
    it "returns a person languages meta information" do
      stub = stub_request('get', %r{.*/people/42pr/languages.json.*})

      described_class.languages(person_id: '42pr') do
      end
      Viki.run
      stub.should have_been_made
    end
  end

  describe "fetch honors of a person" do
    it "returns a person honors information" do
      stub = stub_request('get', %r{.*/people/42pr/honors.json.*})

      described_class.honors(person_id: '42pr') do
      end
      Viki.run
      stub.should have_been_made
    end
  end

  describe "fetch relations of a person" do
    it "returns a person relations information" do
      stub = stub_request('get', %r{.*/people/42pr/relations/es.json.*})

      described_class.relations(person_id: '42pr', language: 'es') do
      end
      Viki.run
      stub.should have_been_made
    end
  end

  describe "fetch the works of a person" do
    it "returns a person works information" do
      stub = stub_request('get', %r{.*/people/42pr/works/es.json.*})

      described_class.works(person_id: '42pr', language: 'es') do
      end
      Viki.run
      stub.should have_been_made
    end
  end
end
