require 'spec_helper'

describe Viki::TimedComment, api: true do
  it "fetches timed comments" do
    stub = stub_request("get", /videos\/1v\/timed_comments\/en.json/)
    described_class.fetch_sync(id: "1v", language: 'en')
    stub.should have_been_made
  end

  it "updates timed comments" do
    stub = stub_request("put", /videos\/1v\/timed_comments.json/)
    described_class.update_sync(id: "1v")
    stub.should have_been_made
  end
end
