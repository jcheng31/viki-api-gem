class Viki::Person < Viki::Core::Base
  cacheable
  LANGUAGES = 'languages'
  HONORS = 'honors'
  RELATIONS = 'relations'
  WORKS = 'works'

  path '/people/:language', api_version: "v4"
  path '/people/:person_id/languages', api_version: "v4", name: LANGUAGES
  path '/people/:person_id/:language', api_version: "v4"
  path '/people/:person_id/honors', api_version: "v4", name: HONORS
  path '/people/:person_id/relations/:language', api_version: "v4", name: RELATIONS
  path '/people/:person_id/works/:language', api_version: "v4", name: WORKS


  def self.languages(options = {}, &block)
    self.fetch(options.merge(named_path: LANGUAGES), &block)
  end

  def self.honors(options = {}, &block)
    self.fetch(options.merge(named_path: HONORS), &block)
  end

  def self.relations(options = {}, &block)
    self.fetch(options.merge(named_path: RELATIONS), &block)
  end

  def self.works(options = {}, &block)
    self.fetch(options.merge(named_path: WORKS), &block)
  end
end
