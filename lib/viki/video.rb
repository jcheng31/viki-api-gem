class Viki::Video < Viki::Core::Base
  path "/videos", api_version: "v5"
  path "/videos/:recommended_for/recommendations", api_version: "v5"
  path "/containers/:container_id/videos", api_version: "v5"
  path "/containers/:container_id/videos/:video_id", api_version: "v5"

  def self.trending(options = {}, &block)
    self.fetch(options.merge(sort: 'trending'), &block)
  end

  def self.recommendations(video_id, options = {}, &block)
    self.fetch(options.merge(recommended_for: video_id), &block)
  end
end