require "spec_helper"

describe Viki::Genre, api: true do
  it "fetches movies genres" do
    VCR.use_cassette "movie_genres" do
      described_class.fetch(resource: "movies") do |response|
        response.value.should be_a_kind_of(Array)
      end
      Viki.run
    end
  end

  it "fetches series genres" do
    VCR.use_cassette "series_genres" do
      described_class.fetch(resource: "series") do |response|
        response.value.should be_a_kind_of(Array)
      end
      Viki.run
    end
  end

  it "fetches music_videos genres" do
    VCR.use_cassette "music_video_genres" do
      described_class.fetch(resource: "music_videos") do |response|
        response.value.should be_a_kind_of(Array)
      end
      Viki.run
    end
  end
end
