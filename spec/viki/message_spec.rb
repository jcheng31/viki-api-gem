require 'spec_helper'

describe Viki::Message, api: true do
  it 'creates a message' do
    stub_api 'users/1u/threads/1t/messages.json', '[]', method: :post
    described_class.create(user_id: '1u', thread_id: '1t', content: '555') do |response|
      response.error.should be_nil
    end
  end
end
