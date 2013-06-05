module Viki
  class Translation < Core::Base
    path 'v4/translations/:type.json'
    path 'v4/translations/:target_subtitle_id/:preference.json'
    
    def self.random(options = {}, &block)
      self.fetch(options.merge(type: 'random'), &block)
    end
    
    def self.rating(options = {}, &block)
      preference = options.delete(:like) ? 'like' : 'dislike'
      self.create(options.merge(preference: preference), &block)
    end
  end
end
