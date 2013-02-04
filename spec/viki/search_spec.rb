require "spec_helper"

describe Viki::Search, api: true do
  it "performs search" do
    described_class.fetch(term: "gangnam") do |response|
      response.value.should be_a_kind_of(Array)
    end
    Viki.run
  end
end
