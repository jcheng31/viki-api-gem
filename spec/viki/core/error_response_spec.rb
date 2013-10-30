require 'spec_helper'

describe Viki::Core::ErrorResponse do
  let(:body) { Oj.dump({"error" => 'Permission is required', "vcode" => 7401, "details" => "details information"}) }
  let(:status) { 401 }
  let(:url) { 'example.com' }

  subject { described_class.new(body, status, url) }

  its(:status) { should == 401 }
  its(:vcode) { should == 7401 }
  its(:url) { should == url }
  its(:error) { should ==  'Permission is required' }

  context 'not found' do
    let(:status) { 404 }

    its(:status) { should == 404 }
    its(:not_found?) { should == true }
    its(:invalid_token?) { should == false }
    its(:client_error?) { should == true }
    its(:server_error?) { should == false }
  end

  context 'invalid token' do
    let(:body) { Oj.dump({"vcode" => 7402}) }

    its(:vcode) { should == 7402 }
    its(:invalid_token?) { should == true }
  end

  context 'internel error' do
    let(:status) { 500 }

    its(:status) { should == 500 }
    its(:not_found?) { should == false }
    its(:invalid_token?) { should == false }
    its(:client_error?) { should == false }
    its(:server_error?) { should == true }
  end
end