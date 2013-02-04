require "spec_helper"

describe Viki::Genre, api: true do
  it "fetches movies genres" do
    described_class.fetch(resource: "movies") do |response|
      response.value.should be_a_kind_of(Array)
    end
    Viki.run
  end

  it "fetches series genres" do
    described_class.fetch(resource: "series") do |response|
      response.value.should be_a_kind_of(Array)
    end
    Viki.run
  end

  it "fetches music_videos genres" do
    described_class.fetch(resource: "music_videos") do |response|
      response.value.should be_a_kind_of(Array)
    end
    Viki.run
  end
end
