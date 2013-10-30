require 'spec_helper'

describe Viki::Core::TimeoutErrorResponse do
  let(:url) { 'example.com' }

  subject { described_class.new(url) }

  its(:status) { should == 408 }
  its(:vcode) { should == 408 }
  its(:error) { should == :timeout }
  its(:timeout?) { should == true }
  its(:invalid_token?) { should == false }
end