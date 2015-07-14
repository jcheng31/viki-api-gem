require 'spec_helper'

describe Viki::EntertainmentAgency, api: true do
  it "fetches years from the API" do
    stub_api 'people/entertainment_agencies.json', json_fixture(:entertainment_agencies)
    Viki::EntertainmentAgency.fetch_sync.value.should == [ {"id" => "1ea", "type" => "entertainment_agency", "titles" => { "en" => "Eden Nine Entertainment" } } ]
  end
end
