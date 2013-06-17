require "spec_helper"

describe Viki::Holdback, api: true do
  it "fetches holdbacks" do
    stub_api 'holdbacks.json', "some_data"
    described_class.fetch(group_ids: "1", user_ids: "1u", resource_id: "1r") do |response|
      response.value.should == "some_data"
    end
    Viki.run
  end
end