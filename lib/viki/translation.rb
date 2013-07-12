class Viki::Translation < Viki::Core::Base
  LIKE = 'like'
  DISLIKE = 'dislike'
  RANDOM = 'random'
  REPORT = 'report'

  path "/translations/random", name: RANDOM
  path "/translations/:target_subtitle_id/like", name: LIKE
  path "/translations/:target_subtitle_id/dislike", name: DISLIKE
  path "/translations/:subtitle_id/report", name: REPORT

  def self.random(options = {}, &block)
    self.fetch(options.merge(named_path: RANDOM), &block)
  end

  def self.rating(options = {}, &block)
    preference = options.delete(:like) ? LIKE : DISLIKE
    self.create(options.merge(named_path: preference), &block)
  end

  def self.report(options = {}, &block)
    self.create(options.merge(named_path: REPORT), &block)
  end
end
