class Viki::Caption < Viki::Core::Base
  RANDOM = 'random'
  LANGUAGES = 'languages'

  path "/captions"
  path "/captions/random", name: RANDOM
  path "/captions/languages", name: LANGUAGES

  def self.random(options = {}, &block)
    self.fetch(options.merge(named_path: RANDOM), &block)
  end

  def self.languages(options = {}, &block)
    self.fetch(options.merge(named_path: LANGUAGES), &block)
  end
end
