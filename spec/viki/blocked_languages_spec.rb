require 'spec_helper'

describe Viki::BlockedLanguages, api: true do
  it "fetches blocked languages for a specific container" do
    stub_api 'containers/1c/blocked_languages.json', Oj.dump({ 'container_id' => '1c', 'languages' => 'th,ko' })
    described_class.fetch(container_id: "1c") do |response|
      response.value.should == { 'container_id' => '1c', 'languages' => 'th,ko' }
    end
  end

  it "creates blocked languages" do
    stub = stub_request('post', %r{.*/containers/1c/blocked_languages.json.*}).
      with(body: Oj.dump('languages' => 'th,ko'))

    described_class.create({ container_id: "1c" }, { 'languages' => 'th,ko' }) do
    end
    Viki.run
    stub.should have_been_made
  end
end
