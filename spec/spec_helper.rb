ENV["RAILS_ENV"] ||= 'test'

require 'rubygems'
require 'bundler/setup'

require 'viki'
require 'vcr'
require 'timecop'
require 'webmock/rspec'

VCR.configure do |c|
  c.cassette_library_dir = File.join(File.dirname(__FILE__), 'vcr_cassettes')
  c.hook_into :webmock
  c.default_cassette_options = {
    match_requests_on: [:method,
                        VCR.request_matchers.uri_without_param(:t, :sig)]}
end

Viki.configure do |c|
  c.logger = nil
end

Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros
  config.include LoginHelper

  config.order = "random"

  config.before(:each, api: true) do
    WebMock.allow_net_connect!
  end

  config.after(:each) do
    Viki.run
  end

  config.after(:each, api: true) do
    WebMock.disable_net_connect!
  end
end
