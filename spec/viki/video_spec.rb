require 'spec_helper'

describe Viki::Video, api: true do
  it "fetches single videos" do
    described_class.fetch(id: "11501v") do |response|
      video = response.value
      video.should be_a_kind_of(Hash)
      video.keys.should include('titles')
    end
    Viki.run
  end

  it "fetches recommendations for episode 1 of BoF" do
    Viki::Video.recommendations("44699v") do |response|
      video = response.value
      video.should be_a_kind_of(Array)
      video.first.keys.should include('titles')
    end
    Viki.run
  end
end
