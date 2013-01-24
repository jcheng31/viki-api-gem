require 'spec_helper'

describe Viki::Country, api: true do
  it "fetches the countries from the API" do
    VCR.use_cassette "Viki::Country_fetch" do
      Viki::Country.find('fr')["native_name"].should == "France"
      Viki::Country.codes.should include 'fr'
    end
  end
end
