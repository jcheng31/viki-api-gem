require 'spec_helper'

describe Viki::Alert, api: true do

  describe "#unread_count" do
    it "fetches with only_count parameter" do
      stub_api 'users/2u/alerts.json', Oj.dump({'count' => 10}), {'unread' => 'true', 'only_count' => 'true'}
      described_class.unread_count("2u") do |response|
        response.value['count'].should == 10
      end
    end
  end

  describe "#unread_count_sync" do
    it "synchronously fetches with only_count parameter" do
      stub_api 'users/2u/alerts.json', Oj.dump({'count' => 10}), {'unread' => 'true', 'only_count' => 'true'}
      described_class.unread_count_sync("2u").value.should == {'count' => 10}
    end
  end
end
