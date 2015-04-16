require "spec_helper"

describe Viki::Brick, api: true do
  it "fetches brick" do
    stub = stub_request('get', %r{.*/v4/bricks/1b.json.*})
    described_class.fetch({id: '1b'}) do
    end
    Viki.run
    stub.should have_been_made
  end

  it "creates brick" do
    stub = stub_request('post', %r{.*/v4/bricks.json}).with(resource_id: '1v', type: 'video')
    described_class.create({}, {resource_id: '1v', type: 'video'}) do
    end
    Viki.run
    stub.should have_been_made
  end

  it "updates brick" do
    stub = stub_request('put', %r{.*/v4/bricks/1b.json}).with(resource_id: '1v', type: 'video')
    described_class.update({id: "1b"}, {resource_id: '1v', type: 'video'}) do
    end
    Viki.run
    stub.should have_been_made
  end

  it "patches brick" do
    stub = stub_request('patch', %r{.*/v4/bricks/1b.json}).with(resource_id: '1v', type: 'video')
    described_class.patch({id: "1b"}, {resource_id: '1v', type: 'video'}) do
    end
    Viki.run
    stub.should have_been_made
  end

  it "deletes brick" do
    stub = stub_request('delete', %r{.*/v4/bricks/1b.json})
    described_class.destroy({id: "1b"}) do
    end
    Viki.run
    stub.should have_been_made
  end
end