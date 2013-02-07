require 'spec_helper'

describe Viki::Core::Base do
  let(:test_klass) {
    Class.new(described_class) do
      path 'path/to/resource.json'
    end
  }

  describe "#uri" do
    let(:nested_test_klass) {
      Class.new(described_class) do
        path 'parent/:parent_id/resource.json'
        path 'other/:other_id/parent/:parent_id/resource.json'
      end
    }

    subject { test_klass.uri }

    its(:authority) { should == Viki.domain }
    its(:path) { should == "/path/to/resource.json" }

    it 'includes the app' do
      subject.query_values["app"].should == Viki.app_id
    end

    it "includes the options" do
      url = test_klass.uri(hello: 'world').to_s
      url.should match("hello=world")
    end

    it "doesn't include the options used to replace the path" do
      url = test_klass.uri(id: 'world').to_s
      url.should_not match("=world")
    end

    it "includes the 'id' param as a resource url" do
      test_klass.uri(id: 'object_id').path.should == "/path/to/resource/object_id.json"
    end

    it "replaces the parents ids for nested resources" do
      path = nested_test_klass.uri(parent_id: 'parent_id').path
      path.should == "/parent/parent_id/resource.json"
    end

    it "uses the path with more matches" do
      nested_test_klass.uri(parent_id: 'parent_id').path.should ==
        "/parent/parent_id/resource.json"
      nested_test_klass.uri(other_id: 'other_id', parent_id: 'parent_id').path.should ==
        "/other/other_id/parent/parent_id/resource.json"
    end

    it "requires the parents for nested resources" do
      expect { nested_test_klass.uri }.to raise_error(Viki::Core::Base::InsufficientOptions)
    end

    it "includes the user country" do
      Viki.stub(:user_country) { lambda { 'it' } }
      test_klass.uri.to_s.should match("watchable_in=it")
    end

    it "includes the user token" do
      Viki.stub(:user_token) { lambda { '12345' } }
      test_klass.uri.to_s.should match("token=12345")
    end

    it "does not include the user token if it's empty" do
      Viki.stub(:user_token) { lambda { '' } }
      test_klass.uri.to_s.should_not match("token=")
    end

    it 'uses https for ssl' do
      test_klass._ssl = true
      test_klass.uri.to_s.should start_with("https")
      test_klass._ssl = false
      test_klass.uri.to_s.should_not start_with("https")
    end
  end

  describe "#signed_uri" do
    let(:uri) { Addressable::URI.parse "http://example.com" }
    let(:body) { "" }
    before { test_klass.should_receive(:uri) { uri } }

    subject { test_klass.signed_uri }

    its(:query_values) { should have_key("t") }
    its(:query_values) { should have_key("sig") }
  end

  describe "#fetch" do
    it "constructs a fetcher from the signed_uri" do
      uri = stub
      options = stub
      test_klass.should_receive(:signed_uri).with(options) { uri }
      Viki::Core::Fetcher.should_receive(:new).with(uri) { stub :queue => nil }
      test_klass.fetch(options) do
      end
    end
  end

  describe "#create" do
    it "constructs a creator from the signed_uri and the body" do
      uri = stub
      options = stub
      body = stub.as_null_object
      test_klass.should_receive(:signed_uri).with(options, body) { uri }
      Viki::Core::Creator.should_receive(:new).with(uri, body) { stub :queue => nil }
      test_klass.create(options, body) do
      end
    end

    it 'serializes files' do
      uri = stub
      options = stub
      f = File.open(__FILE__)
      serialized = Base64.encode64(File.read(__FILE__))

      test_klass.should_receive(:signed_uri).with(options, {"file" => serialized}) { uri }
      Viki::Core::Creator.should_receive(:new).with(uri, {"file" => serialized}) { stub :queue => nil }
      test_klass.create(options, {"file" => f}) do
      end
    end
  end

  describe "#update" do
    it "constructs a updater from the signed_uri and the body" do
      uri = stub
      options = stub
      body = stub.as_null_object
      test_klass.should_receive(:signed_uri).with(options, body) { uri }
      Viki::Core::Updater.should_receive(:new).with(uri, body) { stub :queue => nil }
      test_klass.update(options, body) do
      end
    end

    it 'serializes files' do
      uri = stub
      options = stub
      f = File.open(__FILE__)
      serialized = Base64.encode64(File.read(__FILE__))

      test_klass.should_receive(:signed_uri).with(options, {"file" => serialized}) { uri }
      Viki::Core::Updater.should_receive(:new).with(uri, {"file" => serialized}) { stub :queue => nil }
      test_klass.update(options, {"file" => f}) do
      end
    end
  end

  describe "#destroy" do
    it "constructs a destroyer from the signed_uri and the body" do
      uri = stub
      options = stub
      test_klass.should_receive(:signed_uri).with(options) { uri }
      Viki::Core::Destroyer.should_receive(:new).with(uri, {}) { stub :queue => nil }
      test_klass.destroy(options) do
      end
    end

    it 'serializes files' do
      uri = stub
      options = stub
      f = File.open(__FILE__)
      serialized = Base64.encode64(File.read(__FILE__))

      test_klass.should_receive(:signed_uri).with(options) { uri }
      Viki::Core::Destroyer.should_receive(:new).with(uri, {"file" => serialized}) { stub :queue => nil }
      test_klass.destroy(options, {"file" => f}) do
      end
    end
  end
end
