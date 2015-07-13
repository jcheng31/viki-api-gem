class Viki::Container < Viki::Core::Base
  cacheable
  path '/containers', api_version: "v4"
  path '/containers/:recommended_for/recommendations', api_version: "v4"
  path '/containers/:people_for/people', api_version: "v4"
  path '/containers/:tags_for/tags', api_version: "v4"

  def self.popular(options = {}, &block)
    self.fetch(options.merge(sort: 'views_recent'), &block)
  end

  def self.trending(options = {}, &block)
    self.fetch(options.merge(sort: 'trending'), &block)
  end

  def self.recommendations(container_id, options = {}, &block)
    self.fetch(options.merge(recommended_for: container_id), &block)
  end

  def self.people(container_id, options = {}, &block)
    self.fetch(options.merge(people_for: container_id), &block)
  end

  def self.tags(container_id, options = {}, &block)
    self.fetch(options.merge(tags_for: container_id), &block)
  end
end
