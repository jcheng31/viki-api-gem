class Viki::Container < Viki::Core::Base
  path '/containers', api_version: "v5"
  path '/containers/:recommended_for/recommendations', api_version: "v5"
  path '/containers/:people_for/people', api_version: "v5"
  path '/verticals/:vertical_id/containers', api_version: "v5"

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
end
