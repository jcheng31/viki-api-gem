require 'spec_helper'

describe Viki::Activity, api: true do
  it "fetches activities for a user" do
    stub_api 'users/123u/activities.json', '["1a", "2a"]'
    activities = nil
    described_class.fetch(user_id: '123u'){ |response| activities = response.value }
    Viki.run
    activities.should eq ['1a', '2a']
  end

  it "fetches activities" do
    stub_api 'activities.json', '["1a", "2a"]'
    activities = nil
    described_class.fetch(type: 'all'){|response| activities = response.value }
    Viki.run
    activities.should eq ['1a', '2a']
  end
end
