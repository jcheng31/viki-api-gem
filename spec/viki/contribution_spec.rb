require 'spec_helper'

describe Viki::Contribution, api: true do
  let(:contribution) {
    {
      id: "100048u",
      username: "xMaku93",
      avatar: "http://0.viki.io/u/100048/100048.6dc71ba717339d7eca14c415c1370097b6ac7b36.jpg",
      segments: 0,
      subtitles: 10
    }}

  it "loads container contributions" do
    stub_api 'containers/42c/contributions.json', Oj.dump([contribution])
    described_class.fetch(container_id: '42c') do |response|
      response.value.should == [contribution]
    end
  end

  it "loads video contributions" do
    stub_api 'videos/42v/contributions.json', Oj.dump([contribution])
    described_class.fetch(video_id: '42v') do |response|
      response.value.should == [contribution]
    end
  end
end
