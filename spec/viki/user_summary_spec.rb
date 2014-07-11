require "spec_helper"

describe Viki::UserSummary, api: true do
  it "fetches the user's summary" do
    user_summary_obj = {"id" => "42u",
                "username" => "chinyongviki",
                "name" => "chinyongviki",
                "images" => {"avatar" => {"url" => "photo.jpg?sz=215"}},
                "created_at" => "2013-07-22T01:40:30Z",
                "updated_at" => "2014-06-10T03:31:37Z"}

    stub_api 'users/42u/summary.json', Oj.dump(user_summary_obj), {api_version: 'v4'}
    described_class.fetch(id: '42u') do |response|
      response.value.should == user_summary_obj
    end
  end
end
