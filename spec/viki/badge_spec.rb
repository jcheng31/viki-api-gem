require 'spec_helper'

describe Viki::Badge, api: true do
  describe "index" do
    it "returns all badges" do
      stub = stub_request('get', %r{.*/v5/badges.json.*})
      described_class.fetch do
      end
      Viki.run
      stub.should have_been_made
    end

    context 'with user_id' do
      it 'returns all badges of the user' do
        stub = stub_request('get', %r{.*/v5/users/1u/badges.json.*})
        described_class.fetch(user_id: '1u') do
        end
        Viki.run
        stub.should have_been_made
      end
    end
  end
end
