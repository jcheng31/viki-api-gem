class Viki::Container < Viki::Core::Base

  class << self
    def fetch(url_options = {}, &block)
      path '/containers', api_version: "v5"
      path '/containers/:recommended_for/recommendations', api_version: "v5"
      path '/containers/:people_for/people', api_version: "v5"
      path '/verticals/:vertical_id/containers', api_version: "v5"
      super
    end

    def fetch_sync(url_options = {})
      path '/containers', api_version: "v5"
      path '/containers/:recommended_for/recommendations', api_version: "v5"
      path '/containers/:people_for/people', api_version: "v5"
      path '/verticals/:vertical_id/containers', api_version: "v5"
      super
    end

    def create(url_options = {}, body = {}, &block)
      path '/containers', api_version: "v4"
      super
    end

    def create_sync(url_options = {}, body = {})
      path '/containers', api_version: "v4"
      super
    end

    def destroy(url_options = {}, &block)
      path '/containers', api_version: "v4"
      super
    end

    def destroy_sync(url_options = {})
      path '/containers', api_version: "v4"
      super
    end

    def update(url_options = {}, body = {}, &block)
      path '/containers', api_version: "v4"
      super
    end

    def update_sync(url_options = {}, body = {})
      path '/containers', api_version: "v4"
      super
    end
  end


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
