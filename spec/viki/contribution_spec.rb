require 'spec_helper'

describe Viki::Contribution, api: true do
  let(:contribution) {
    {
      'id' => "100048u",
      'username' => "xMaku93",
      'avatar' => "http://0.viki.io/u/100048/100048.6dc71ba717339d7eca14c415c1370097b6ac7b36.jpg",
      'segments' => 0,
      'subtitles' => 10
    }
  }

  let(:lists) {
    [{ 'id' => '1l', 'contribution_type' => 'subtitle', 'language_code' => 'en' }]
  }

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

  it "loads lists for contributors" do
    stub_api 'contributions/recommendation_lists.json', Oj.dump(lists)
    described_class.recommendation_lists do |response|
      response.value.should == lists
    end
  end

  it "marks a user as a condidate" do
    stub = stub_request('put', %r{.*/users/42u/contributions/mark_as_candidate.json.*})
    described_class.mark_as_candidate(user_id: '42u') {}
    Viki.run
    stub.should have_been_made
  end
end
