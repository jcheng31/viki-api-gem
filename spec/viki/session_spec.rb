require "spec_helper"

describe Viki::Session, api: true do
  describe '.authenticate' do
    it 'raises error when the authentication fails' do
      described_class.authenticate('qaviki01', 'WrongPassword') do |exception, response|
        exception.should_not be_nil
        response.should be_nil
      end
      Viki.run
    end

    it 'sends the persist option' do
      described_class.should_receive(:signed_uri).with({}, hash_including('persist' => true)) { '' }
      Viki::Core::Creator.should_receive(:new) { stub(:queue => nil) }
      described_class.authenticate('qaviki01', 'WrongPassword', true)
      Viki.run
    end
  end
end
