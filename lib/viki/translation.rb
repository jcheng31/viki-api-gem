module Viki
  class Translation < Core::Base
    LIKE = 'like'
    DISLIKE = 'dislike'
    RANDOM = 'random'

    path 'v4/translations/random.json', name: RANDOM
    path 'v4/translations/:target_subtitle_id/like.json', name: LIKE
    path 'v4/translations/:target_subtitle_id/dislike.json', name: DISLIKE

    def self.random(options = {}, &block)
      self.fetch(options.merge(named_path: RANDOM), &block)
    end

    def self.rating(options = {}, &block)
      preference = options.delete(:like) ? LIKE : DISLIKE
      self.create(options.merge(named_path: preference), &block)
    end
  end
end
