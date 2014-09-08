require 'spec_helper'

describe Viki::MetaCountry, api: true do
  it "fetches the countries from the API" do
    stub_api 'countries2.json', json_fixture(:countries)
    Viki::MetaCountry.find('ca')["native_name"].should == "Canada"
    Viki::MetaCountry.codes.should include 'ca'
  end
end
