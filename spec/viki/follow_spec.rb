require 'spec_helper'

describe Viki::Follow, api: true do
  let(:following_list) {
    {
      'id' => "2u",
      'username' => "aysha"
    }
  }

  let(:followers_list) {
    {
      'id' => "1u",
      'username' => "andrew"
    }
  }

  it "loads following list" do
    stub_api 'users/3u/followings.json', Oj.dump([following_list])
    described_class.followings('3u') do |response|
      response.value.should == [following_list]
    end
  end

  it "loads followers list" do
    stub_api 'users/3u/followers.json', Oj.dump([followers_list])
    described_class.followers('3u') do |response|
      response.value.should == [followers_list]
    end
  end
end