require 'spec_helper'

describe Viki::Thread, api: true do
  it "fetches a thread" do
    stub_api 'users/1t/threads/11501t.json', Oj.dump({ a: true }), { type: 'inbox' }
    described_class.fetch(id: "11501t", user_id: '1t', type: 'inbox') do |response|
      response.value[:a].should be_true
    end
  end
end
