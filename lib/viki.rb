require 'logger'
require_relative 'logger'
require 'oj'
require 'typhoeus'
require 'ostruct'
require 'openssl'
require 'addressable/uri'
require 'viki_utils'
require 'base64'

module Viki
  class << self
    attr_accessor :salt, :app_id, :domain, :logger, :user_ip, :user_token, :signer, :hydra, :timeout_seconds
  end

  def self.run
    if defined?(::ActiveSupport::Notifications)
      ActiveSupport::Notifications.instrument("viki-api.fetch") do
        @hydra.run
      end
    else
      @hydra.run
    end
  ensure
    @hydra = Typhoeus::Hydra.new
  end

  def self.configure(&block)
    configurator = Configurator.new
    block.call configurator

    @signer = Viki::UriSigner.new(configurator.salt)
    @salt = configurator.salt
    @app_id = configurator.app_id
    @domain = configurator.domain
    @timeout_seconds = configurator.timeout_seconds
    @logger = Viki::Logger.new(configurator.logger)
    @user_ip = configurator.user_ip
    @user_token = configurator.user_token
    @hydra = Typhoeus::Hydra.new
    nil
  end

  class Configurator
    attr_accessor :salt, :app_id, :domain, :logger, :user_ip, :user_token, :timeout_seconds

    def initialize
      @salt = ENV["VIKI_API_SALT"]
      @app_id = ENV["VIKI_API_APP_ID"]
      @domain = ENV["VIKI_API_DOMAIN"]
      @logger = ::Logger.new(STDOUT)
      @logger.level = ::Logger::INFO
      @user_ip = lambda { }
      @user_token = lambda { }
      @timeout_seconds = 10
    end
  end
end

Viki::configure{}

['core', '', 'container', 'video'].each do |dir|
  Dir[File.join(File.dirname(__FILE__), "viki/#{dir}", '*.rb')].each { |f| require f }
end