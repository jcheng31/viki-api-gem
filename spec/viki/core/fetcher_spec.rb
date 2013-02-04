require 'spec_helper'

describe Viki::Core::Fetcher do
  describe '#fetch' do
    let(:content) { {'title' => 'City Hunter'} }
    let(:status) { 200 }
    let(:fetcher) { Viki::Core::Fetcher.new("http://example.com/path") }

    before do
      stub_request("get", "http://example.com/path").to_return(body: Oj.dump(content, mode: :compat),
                                                               status: status)
    end

    it "returns the results of the call to the API" do
      fetcher.queue do |response|
        response.value['title'].should == 'City Hunter'
      end
    end

    it "sends the user IP as X-FORWARDED-FOR" do
      Viki.should_receive(:user_ip) { lambda { "1.2.3.4" } }
      fetcher.queue do
        WebMock.should have_requested("get", "http://example.com/path").
                         with(:headers => {'X-Forwarded-For' => "1.2.3.4"})
      end
    end

    context "error response" do
      let(:content) { {"error" => "an error occurred", "vcode" => 123} }
      let(:status) { 401 }

      it 'yields the error' do
        fetcher.queue do |response|
          response.value.should be_nil
          error = response.error
          error.should be_a(Viki::Core::BaseRequest::ErrorResponse)
          error.status.should == 401
          error.error.should == "an error occurred"
          error.vcode.should == 123
          error.url.should == "http://example.com/path"
        end
      end
    end

    context "from list responses" do
      let(:content) { {
        'more' => true,
        'response' => [
        ]
      } }

      it 'loads the pagination field' do
        fetcher.queue {}
        Viki.run
        fetcher.more.should be_true
        fetcher.count.should be_nil
      end

      context "with_paging" do
        let(:content) { {
          'count' => 10,
          'pagination' => {
            'previous' => nil,
            'next' => "http://example.com/page2"
          },
          'response' => [
            {'title' => 'City Hunter'},
            {'title' => 'Bof'},
          ]
        } }

        it 'loads the pagination info' do
          fetcher.queue {}
          Viki.run
          fetcher.more.should === true
          fetcher.count.should == 10
        end
      end
    end
  end
end
