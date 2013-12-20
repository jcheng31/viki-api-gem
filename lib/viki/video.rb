class Viki::Video < Viki::Core::Base
  class << self
    def fetch(url_options = {}, &block)
      path "/videos", api_version: "v5"
      path "/videos/:recommended_for/recommendations", api_version: "v5"
      path "/containers/:container_id/videos", api_version: "v5"
      path "/containers/:container_id/videos/:video_id", api_version: "v5"
      super
    end

    def fetch_sync(url_options = {})
      path "/videos", api_version: "v5"
      path "/videos/:recommended_for/recommendations", api_version: "v5"
      path "/containers/:container_id/videos", api_version: "v5"
      path "/containers/:container_id/videos/:video_id", api_version: "v5"
      super
    end

    def create(url_options = {}, body = {}, &block)
      path '/videos', api_version: "v4"
      path "/containers/:container_id/videos", api_version: "v4"
      super
    end

    def create_sync(url_options = {}, body = {})
      path '/videos', api_version: "v4"
      path "/containers/:container_id/videos", api_version: "v4"
      super
    end

    def destroy(url_options = {}, &block)
      path '/videos', api_version: "v4"
      path "/containers/:container_id/videos", api_version: "v4"
      path "/containers/:container_id/videos/:video_id", api_version: "v4"
      super
    end

    def destroy_sync(url_options = {})
      path '/videos', api_version: "v4"
      path "/containers/:container_id/videos", api_version: "v4"
      path "/containers/:container_id/videos/:video_id", api_version: "v4"
      super
    end

    def update(url_options = {}, body = {}, &block)
      path '/videos', api_version: "v4"
      path "/containers/:container_id/videos", api_version: "v4"
      path "/containers/:container_id/videos/:video_id", api_version: "v4"
      super
    end

    def update_sync(url_options = {}, body = {})
      path '/videos', api_version: "v4"
      path "/containers/:container_id/videos", api_version: "v4"
      path "/containers/:container_id/videos/:video_id", api_version: "v4"
      super
    end
  end

  def self.trending(options = {}, &block)
    self.fetch(options.merge(sort: 'trending'), &block)
  end

  def self.recommendations(video_id, options = {}, &block)
    self.fetch(options.merge(recommended_for: video_id), &block)
  end
end