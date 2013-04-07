require 'spec_helper'

describe Viki::Contribution, api: true do
  let(:contribution) {
    {
      'id' => "100048u",
      'username' => "xMaku93",
      'avatar' => "http://0.viki.io/u/100048/100048.6dc71ba717339d7eca14c415c1370097b6ac7b36.jpg",
      'segments' => 0,
      'subtitles' => 10
    }}

  it "loads container contributions" do
    stub_api 'containers/42c/contributions.json', Oj.dump([contribution])
    described_class.fetch(container_id: '42c') do |response|
      response.value.should == [contribution]
    end
  end

  it "loads user contributions" do
    stub_api 'users/42u/contributions.json', Oj.dump([contribution])
    described_class.fetch(user_id: '42u') do |response|
      response.value.should == [contribution]
    end
  end
end
