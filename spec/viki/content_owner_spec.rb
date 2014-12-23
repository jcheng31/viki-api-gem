require 'spec_helper'

describe Viki::ContentOwner, api: true do
  it "loads content owner" do
    stub_api 'content_owners/21co.json', Oj.dump({ 'id' => "21co", 'names' => { 'en' => "SBS Content Hub" },
                                                   'descriptions' => {}, 'images' => {}, 'lists' => {},
                                                   'url' => { 'web' => "http://www.viki.com/provider/21co",
                                                              'api' => "http://api.viki.io/v4/content_owners/21co.json"
                                                   } })
    described_class.fetch(id: '21co') do |response|
      response.value.should == { 'id' => "21co", 'names' => { 'en' => "SBS Content Hub" },
                                 'descriptions' => {}, 'images' => {}, 'lists' => {},
                                 'url' => { 'web' => "http://www.viki.com/provider/21co",
                                           'api' => "http://api.viki.io/v4/content_owners/21co.json"
                                 } }

    end
  end

  describe "with containers_for parameter" do
    it "loads containers" do
      stub_api 'content_owners/42co/containers.json', Oj.dump(json_fixture(:containers))
      described_class.fetch(containers_for: '42co') do |response|
        response.value.should == json_fixture(:containers).force_encoding('UTF-8')
      end
    end
  end
end
