class Viki::Translation < Viki::Core::Base
  LIKE = 'like'
  DISLIKE = 'dislike'
  RANDOM = 'random'

  path "/translations/random", name: RANDOM
  path "/translations/:target_subtitle_id/like", name: LIKE
  path "/translations/:target_subtitle_id/dislike", name: DISLIKE

  def self.random(options = {}, &block)
    self.fetch(options.merge(named_path: RANDOM), &block)
  end

  def self.rating(options = {}, &block)
    preference = options.delete(:like) ? LIKE : DISLIKE
    self.create(options.merge(named_path: preference), &block)
  end
end