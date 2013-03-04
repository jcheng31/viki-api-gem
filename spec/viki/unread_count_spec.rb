require 'spec_helper'

describe Viki::UnreadCount, api: true do
  it 'gets message unread count' do
    stub_api 'users/1u/threads/unread_count.json', Oj.dump({ count: 5 })
    described_class.fetch(user_id: '1u') do |response|
      response.value[:count].should == 5
    end
  end
end
