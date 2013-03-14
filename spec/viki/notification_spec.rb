require 'spec_helper'

describe Viki::Notification, api: true do
  it "creates a notification" do
    stub_api 'notifications.json', Oj.dump({ a: true }), { method: 'post' }
    described_class.create(container_id: '1c', content: 'Hi followers') do |response|
      response.value[:a].should be_true
    end
  end

  it "fetches notifications" do
    stub_api 'users/1u/notifications/11501n.json', Oj.dump({ a: true })
    described_class.fetch(id: "11501n", user_id: '1u') do |response|
      response.value[:a].should be_true
    end
  end

  describe "#unread_count" do
    it "fetches with only_count parameter" do
      stub_api 'users/2u/notifications.json', Oj.dump({ count: 10 }), { unread: 'true', only_count: 'true' }
      described_class.unread_count("2u") do |response|
        response.value[:count].should == 10
      end
    end
  end
  describe "#unread_count_sync" do
    it "synchronously fetches with only_count parameter" do
      stub_api 'users/2u/notifications.json', Oj.dump({ count: 10 }), { unread: 'true', only_count: 'true' }
      described_class.unread_count_sync("2u").value.should == { count: 10 }
    end
  end
end
