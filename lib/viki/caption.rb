class Viki::Caption < Viki::Core::Base
  RANDOM = 'random'

  path "/captions"
  path "/captions/random", name: RANDOM

  def self.random(options = {}, &block)
    self.fetch(options.merge(named_path: RANDOM), &block)
  end
end
