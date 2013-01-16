module Viki
  class Container < Viki::Core::Base
    path 'v4/containers.json'

    def self.popular(options = {}, &block)
      self.fetch(options.merge(sort: 'views_recent'), &block)
    end

    def self.upcoming(options = {}, &block)
      self.fetch(options.merge(state: '3'), &block)
    end

    def self.trending(options = {}, &block)
      self.fetch(options.merge(sort: 'trending'), &block)
    end

  end
end
