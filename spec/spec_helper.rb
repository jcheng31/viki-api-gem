ENV["RAILS_ENV"] ||= 'test'

require 'rubygems'
require 'bundler/setup'

require 'viki'
require 'timecop'
require 'webmock/rspec'

Viki.configure do |c|
  c.logger = Logger.new(STDOUT)
end

Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
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
