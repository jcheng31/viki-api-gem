require "spec_helper"

describe Viki::User, api: true do
  it "fetches the user" do
    user_obj = {"id" =>"42u",
            "username" =>"viki",
            "name" =>"viki",
            "images" => {"avatar" =>{"url" =>"photo.jpg?sz=215"}},
            "created_at" => "2013-07-22T01:40:30Z",
            "updated_at" =>"2014-06-10T03:31:37Z"}

    stub_api 'users/42u.json', Oj.dump(user_obj), {api_version: 'v4', https: true}
    described_class.fetch(id: '42u') do |response|
      response.value.should == user_obj
    end
  end
end
