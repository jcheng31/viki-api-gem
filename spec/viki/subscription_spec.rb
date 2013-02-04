require 'spec_helper'

describe Viki::Subscription, api: true do
  let(:user_id) { login_as 'hannah.carleen@gmail.com', 'testing' }

  it "fetches subscriptions for a user" do
    videos = nil
    described_class.fetch(user_id: user_id) { |response| videos = response.value }
    Viki.run
    videos.should be_a_kind_of(Array)
  end

  it "creates subscriptions" do
    stub = stub_request('post', %r{.*/users/1u/subscriptions.json.*}).
      with(body: Oj.dump({'resource_id' => "2c"}))

    described_class.create({user_id: "1u"}, {'resource_id' => "2c"}) do
    end
    Viki.run
    stub.should have_been_made
  end

  it "deletes subscriptions" do
    stub = stub_request('delete', %r{.*/users/1u/subscriptions/2c.json.*})

    described_class.destroy({user_id: "1u", id: "2c"}) do
    end
    Viki.run
    stub.should have_been_made
  end
end
