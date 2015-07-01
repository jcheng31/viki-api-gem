class Viki::Tag < Viki::Core::Base
  cacheable
  LANGUAGES = 'languages'

  path '/tags'
  path '/tags/:id'
  path '/tags/:id/languages', name: LANGUAGES
  path '/:resource/tags'
  path '/:resource/:id/tags'

  def self.tags_languages(options = {}, &block)
    self.fetch(options.merge(named_path: LANGUAGES), &block)
  end
end
