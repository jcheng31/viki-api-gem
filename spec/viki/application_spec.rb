require 'spec_helper'

describe Viki::Application, api: true do
  it "fetches the applications" do
    stub_api 'applications.json', json_fixture(:applications)
    described_class.fetch do |response|
      response.value.first["id"].should == "42a"
    end
  end
end
