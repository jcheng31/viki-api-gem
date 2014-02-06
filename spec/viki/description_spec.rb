require 'spec_helper'

describe Viki::Description, api: true do
  it "up-sert a description" do
    stub = stub_request('post', %r{.*/containers/42c/descriptions.json.*}).
        with(body: Oj.dump({'title' => "This is Sparta!", 'language_code' => "kr",}))

    described_class.create({container_id: "42c"}, {'title' => "This is Sparta!", 'language_code' => 'kr'}) do
    end
    Viki.run
    stub.should have_been_made
  end

  it "up-sert a description" do
    stub = stub_request('post', %r{.*/videos/42v/descriptions.json.*}).
        with(body: Oj.dump({'title' => "This is Sparta!", 'language_code' => "kr", }))

    described_class.create({video_id: "42v"}, {'title' => "This is Sparta!", 'language_code' => 'kr'}) do
    end
    Viki.run
    stub.should have_been_made
  end

  it "destroy a container description" do
    stub = stub_request('delete', %r{.*/containers/42v/descriptions/ja.json.*})
    described_class.destroy({container_id: "42v", language_code: "ja"}) do
    end
    Viki.run
    stub.should have_been_made
  end

  it "destroy a video description" do
    stub = stub_request('delete', %r{.*/videos/42v/descriptions/ja.json.*})
    described_class.destroy({video_id: "42v", language_code: "ja"}) do
    end
    Viki.run
    stub.should have_been_made
  end
end
