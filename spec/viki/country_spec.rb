require 'spec_helper'

describe Viki::Country, api: true do
  it "fetches the countries from the API" do
    stub_api 'countries.json', json_fixture(:countries)
    Viki::Country.find('ca')["native_name"].should == "Canada"
    Viki::Country.codes.should include 'ca'
  end
end
