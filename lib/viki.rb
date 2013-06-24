require 'viki/logger'
require 'oj'
require 'typhoeus'
require 'ostruct'
require 'openssl'
require 'addressable/uri'
require 'viki_utils'
require 'base64'

module Viki
  class << self
    attr_accessor :salt, :app_id, :domain, :manage, :logger, :user_ip, :user_token, :signer, :hydra, :timeout_seconds, :timeout_seconds_post
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
    @manage = configurator.manage
    @timeout_seconds = configurator.timeout_seconds
    @timeout_seconds_post = configurator.timeout_seconds_post
    @logger = configurator.logger
    @user_ip = configurator.user_ip
    @user_token = configurator.user_token
    @hydra = Typhoeus::Hydra.new
    nil
  end

  class Configurator
    attr_reader :logger
    attr_accessor :salt, :app_id, :domain, :manage, :user_ip, :user_token, :timeout_seconds, :timeout_seconds_post

    def logger=(v)
      @logger.level = Viki::Logger::FATAL if v.nil?
    end

    def initialize
      @salt = ENV["VIKI_API_SALT"]
      @app_id = ENV["VIKI_API_APP_ID"]
      @domain = ENV["VIKI_API_DOMAIN"]
      @manage = ENV["VIKI_MANAGE_DOMAIN"]
      @logger = Viki::Logger.new(STDOUT)
      @logger.level = Viki::Logger::INFO
      @user_ip = lambda { }
      @user_token = lambda { }
      @timeout_seconds = 5
      @timeout_seconds_post = 10
    end
  end
end

Viki::configure{}

require 'viki/core/base_request'
require 'viki/core/fetcher'
require 'viki/core/creator'
require 'viki/core/updater'
require 'viki/core/destroyer'
require 'viki/core/base'
require 'viki/core/response'
require 'viki/core/error_response'

['', 'container', 'video'].each do |dir|
  Dir[File.join(File.dirname(__FILE__), "viki/#{dir}", '*.rb')].each { |f| require f }
end
