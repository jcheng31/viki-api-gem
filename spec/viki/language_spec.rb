require 'spec_helper'

describe Viki::Language, api: true do
  it "fetches the countries from the API" do
    stub_api 'languages.json', json_fixture(:languages)
    Viki::Language.find('it')["native_name"].should == "Italiano"
    Viki::Language.codes.should include 'it'
  end
end
