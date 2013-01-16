shared_examples_for "a video object" do

  it "fetches videos" do
    VCR.use_cassette "#{described_class.name}_videos" do
      described_class.fetch do |response|
        videos = response.value
        videos.should be_a_kind_of(Array)
        videos.first.keys.should include('titles')
      end
      Viki.run
    end
  end

  describe ".trending" do
    it "sorts by trending" do
      described_class.should_receive(:fetch).with sort: 'trending'
      described_class.trending
    end

    it "accepts options" do
      described_class.should_receive(:fetch).with sort: 'trending', a: 1
      described_class.trending(a: 1)
    end
  end
end
