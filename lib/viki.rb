require 'logger'
require 'oj'
require 'typhoeus'
require 'ostruct'
require 'openssl'
require 'addressable/uri'
require 'viki_utils'

module Viki
  class << self
    attr_accessor :salt, :app_id, :domain, :logger, :user_ip, :user_token, :user_country, :signer
  end

  def self.run
    if defined?(::ActiveSupport::Notifications)
      ActiveSupport::Notifications.instrument("viki-api.fetch") do
        Typhoeus::Hydra.hydra.run
      end
    else
      Typhoeus::Hydra.hydra.run
    end
  end

  def self.configure(&block)
    configurator = Configurator.new
    block.call configurator

    @signer = Viki::UriSigner.new(configurator.salt)
    @salt = configurator.salt
    @app_id = configurator.app_id
    @domain = configurator.domain
    @logger = Viki::Logger.new(configurator.logger)
    @user_ip = configurator.user_ip
    @user_token = configurator.user_token
    @user_country = configurator.user_country
    nil
  end

  class Configurator
    attr_accessor :salt, :app_id, :domain, :logger, :user_ip, :user_token, :user_country

    def initialize
      @salt = ENV["VIKI_API_SALT"]
      @app_id = ENV["VIKI_API_APP_ID"]
      @domain = ENV["VIKI_API_DOMAIN"]
      @logger = ::Logger.new(STDOUT)
      @logger.level = ::Logger::INFO
      @user_ip = lambda { }
      @user_token = lambda { }
      @user_country = lambda { }
    end
  end
end

require 'viki/logger'
require 'viki/version'

Viki::configure{}

require 'viki/core/base_request'
require 'viki/core/fetcher'
require 'viki/core/creator'
require 'viki/core/destroyer'
require 'viki/core/base'
require 'viki/core/response'

require 'viki/user'
require 'viki/session'

require 'viki/video'
require 'viki/episode'
require 'viki/clip'
require 'viki/movie'
require 'viki/music_video'
require 'viki/news_clip'

require 'viki/container'
require 'viki/artist'
require 'viki/film'
require 'viki/news'
require 'viki/series'

require 'viki/list'
require 'viki/genre'
require 'viki/subscription'
require 'viki/holdback'
require 'viki/search'

require 'viki/cover'
require 'viki/country'
require 'viki/language'
