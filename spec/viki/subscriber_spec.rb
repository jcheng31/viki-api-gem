require 'spec_helper'

describe Viki::Subscriber, api: true do
  it "fetches list of subscriber ids" do
    stub_api 'containers/1c/subscribers.json', Oj.dump(%w(1u 2u))
    described_class.fetch(resource_id: '1c') do |response|
      response.value.should == %w(1u 2u)
    end
  end
end
