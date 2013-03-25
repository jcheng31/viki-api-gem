require 'spec_helper'

describe Viki::Description, api: true do
  it "up-sert a title" do
    stub = stub_request('post', %r{.*/containers/42c/description.json.*}).
        with(body: Oj.dump({'title' => "This is Sparta!", 'language_code' => "kr",}))

    described_class.create({container_id: "42c"}, {'title' => "This is Sparta!", 'language_code' => 'kr'}) do
    end
    Viki.run
    stub.should have_been_made
  end
end
