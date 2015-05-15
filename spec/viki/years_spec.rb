require 'spec_helper'

describe Viki::Years, api: true do
  it "fetches years from the API" do
    stub_api 'containers/years.json', json_fixture(:years)
    Viki::Years.fetch_sync.value.should == ["1920", "1921", "1922", "1923"]
  end
end
