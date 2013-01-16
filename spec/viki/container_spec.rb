require 'spec_helper'

describe Viki::Container, api: true do
  it_behaves_like "a container object"

  it "fetches single container" do
    VCR.use_cassette "Viki::Container_one_container" do
      described_class.fetch(id: "1411c") do |response|
        video = response.value
        video.should be_a_kind_of(Hash)
        video.keys.should include('titles')
      end
      Viki.run
    end
  end
end
