ENV["RAILS_ENV"] ||= 'test'
ENV['VIKI_API_DOMAIN'] = 'api.dev.viki.io'
ENV['VIKI_API_APP_ID'] = '70000a'
ENV['VIKI_API_SALT'] = 'apples'

require 'rubygems'
require 'bundler/setup'

require 'viki'
require 'timecop'
require 'webmock/rspec'

Viki.configure do |c|
  c.logger = nil
end

Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.include JsonFixtures
  config.include ApiStub

  config.order = "random"

  config.after(:each) do
    Viki.run
  end

  config.after(:each, api: true) do
    WebMock.disable_net_connect!
  end
end
