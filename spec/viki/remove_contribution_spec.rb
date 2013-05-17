require 'spec_helper'

describe Viki::RemoveContribution, api: true do
  it 'delete all contributions of the user' do
    response = stub
    described_class.should_receive(:destroy).with(user_id: '42u', ).and_yield(response)
    described_class.remove_user_contributions('42u') do |r|
      r.should == response
    end
  end
end
