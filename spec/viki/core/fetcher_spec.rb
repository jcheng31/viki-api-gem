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
      Viki.stub(:user_ip) { lambda { "1.2.3.4" } }
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
          error.should be_a(Viki::Core::ErrorResponse)
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

    describe "caching" do
      let(:fetcher) { Viki::Core::Fetcher.new("http://example.com/path", nil, "json", {cache_seconds: 5}) }
      let(:cache) do
        {}.tap { |c|
          def c.setex(k, s, v)
            self[k] = v
          end

          def c.get(k)
            self[k]
          end

          def c.expire(k, s)
          end
        }
      end

      it "caches the API requests" do
        Viki.stub(:cache) { cache }
        fetcher.queue do
          fetcher.queue do
            WebMock.should have_requested("get", "http://example.com/path").once
          end
        end
      end

      it "doesn't cache if caching is not setup" do
        fetcher.queue do
          fetcher.queue do
            WebMock.should have_requested("get", "http://example.com/path").twice
          end
        end
      end

      it "doesn't cache if request has nocache=true" do
        stub_request("get", "http://example.com/path?nocache=true").
            to_return(body: Oj.dump(content, mode: :compat), status: status)
        nocache_fetcher = Viki::Core::Fetcher.new("http://example.com/path?nocache=true", nil, {cache_seconds: 5})
        nocache_fetcher.queue do
          nocache_fetcher.queue do
            WebMock.should have_requested("get", "http://example.com/path?nocache=true").twice
          end
        end
      end

      it "ignores t, sig and token parameters" do
        Viki.stub(:cache) { cache }
        stub_request("get", "http://example.com/path?other=a&t=123&sig=abc&token=123").to_return(body: Oj.dump(content, mode: :compat), status: status)
        stub_request("get", "http://example.com/path?other=b&t=123&sig=abc&token=123").to_return(body: Oj.dump(content, mode: :compat), status: status)

        Viki::Core::Fetcher.new("http://example.com/path?other=a&t=123&sig=abc&token=123", nil, {cache_seconds: 5}).queue do
          Viki::Core::Fetcher.new("http://example.com/path?other=b&t=123&sig=abc&token=123", nil, {cache_seconds: 5}).queue do
            WebMock.should have_requested("get", "http://example.com/path?other=a&t=123&sig=abc&token=123").once
            WebMock.should have_requested("get", "http://example.com/path?other=b&t=123&sig=abc&token=123").once
          end
        end
      end

      it 'uses the last character of the user token for caching, ignoring the rest' do
        Viki.stub(:cache) { cache }
        stub_request("get", "http://example.com/path?token=1234_13").to_return(:body => Oj.dump(content))
        stub_request("get", "http://example.com/path?token=1234_13").to_return(:body => Oj.dump(content))

        Viki::Core::Fetcher.new("http://example.com/path?token=1234_13", nil, 'json', {cache_seconds: 5}).queue do
          Viki::Core::Fetcher.new("http://example.com/path?token=1234_13", nil, 'json', {cache_seconds: 5}).queue do
            WebMock.should have_requested("get", "http://example.com/path?token=1234_13").once
            WebMock.should have_requested("get", "http://example.com/path?token=1234_13").once
          end
        end
      end
    end
  end
end
