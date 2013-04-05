require 'spec_helper'

describe Viki::Thread, api: true do
  it "fetches a thread" do
    stub_api 'users/1u/threads/11501t.json', Oj.dump({'a' => true}), {'type' => 'inbox'}
    described_class.fetch(id: "11501t", user_id: '1u', type: 'inbox') do |response|
      response.value['a'].should be_true
    end
  end
  describe "#unread_count" do
    it "fetches with only_count parameter" do
      stub_api 'users/2u/threads.json', Oj.dump({'count' => 10}), {'type' => 'inbox', 'unread' => 'true', 'only_count' => 'true'}
      described_class.unread_count("2u") do |response|
        response.value['count'].should == 10
      end
    end
  end
  describe "#unread_count_sync" do
    it "synchronously fetches with only_count parameter" do
      stub_api 'users/2u/threads.json', Oj.dump({'count' => 10}), {'type' => 'inbox', 'unread' => 'true', 'only_count' => 'true'}
      described_class.unread_count_sync("2u").value.should == {'count' => 10}
    end
  end
end
