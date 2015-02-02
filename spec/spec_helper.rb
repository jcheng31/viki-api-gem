ENV["RAILS_ENV"] ||= 'test'
ENV['VIKI_API_DOMAIN'] = 'api.dev.viki.io'
ENV['VIKI_MANAGE_DOMAIN'] = 'manage.dev.viki.io'
ENV['VIKI_API_APP_ID'] = '70000a'
ENV['VIKI_API_SALT'] = 'apples'

require 'rubygems'
require 'bundler/setup'
require 'viki'
require 'timecop'
require 'webmock/rspec'

Dir[File.join(File.dirname(__FILE__), "support/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.include JsonFixtures
  config.include ApiStub
  config.order = "random"

  config.before(:each) do
    Viki.configure do |c|
      c.logger = nil
    end
  end

  config.after(:each) do
    Viki.run
    Thread.current[:typhoeus_hydra] = nil
  end

  config.after(:each, api: true) do
    WebMock.disable_net_connect!
  end
end
