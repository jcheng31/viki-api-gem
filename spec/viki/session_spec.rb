require "spec_helper"

describe Viki::Session, api: true do
  describe '.authenticate' do
    it 'authenticates the user' do
      stub_api 'sessions.json', '{"token": "123456"}',
               method: :post
      described_class.authenticate('user', 'pass') do |response|
        response.error.should be_nil
      end
    end

    it 'raises error when the authentication fails' do
      stub_api 'sessions.json', '{"vcode": "404"}',
               method: :post, response_code: 404
      described_class.authenticate('user', 'pass') do |response|
        response.error.should_not be_nil
      end
    end
  end
end
