require 'spec_helper'

describe Viki::Like, api: true do
  it "fetches likes for a user" do
    stub_api 'users/123u/likes.json', '["1v", "2v"]'
    likes = nil
    described_class.fetch(user_id: '123u'){ |response| likes = response.value }
    Viki.run
    likes.should eq ['1v', '2v']
  end
end
