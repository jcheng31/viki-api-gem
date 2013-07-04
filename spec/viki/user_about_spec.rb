require 'spec_helper'

describe Viki::UserAbout, api: true do
  it "fetches a single about page" do
    stub_api 'users/1u/about.json', json_fixture(:about)
    described_class.fetch(user_id: "1u") do |response|
      response.value.keys.should include("about")
    end
  end
end
