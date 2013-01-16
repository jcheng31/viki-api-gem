require "spec_helper"

describe Viki::Holdback, api: true do
  it "fetches holdback" do
    VCR.use_cassette "holdbacks" do
      described_class.fetch(ids: "1,2,3") do |response|
        response.value.should be_a_kind_of(Array)
      end
      Viki.run
    end
  end
end
