require 'spec_helper'

describe Viki::Device, api: true do
  it "link a user" do
    stub = stub_request('post', %r{.*v5/users/2u/link.json.*}).with(:body => {device_registration_code: '42abc', type: 'roku'})
    described_class.link('2u', {device_registration_code: '42abc', type: 'roku'}) do |response|
    end
    Viki.run
    stub.should have_been_made
  end

  it "unlink a user" do
    stub = stub_request('delete', %r{.*v5/users/2u/unlink/42abc.json.*}).with(:body => {})
    described_class.unlink('2u', {device_token: '42abc'}) do |response|
    end
    Viki.run
    stub.should have_been_made
  end

  it "gets devices" do
    stub = stub_request('get', %r{.*v5/users/2u/devices.json.*})
    described_class.fetch(user_id: '2u') do |response|
    end
    Viki.run
    stub.should have_been_made
  end
end
