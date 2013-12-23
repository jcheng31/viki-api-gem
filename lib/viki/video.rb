class Viki::Video < Viki::Core::Base
    path "/videos"
    path "/videos/:recommended_for/recommendations"
    path "/containers/:container_id/videos"
    path "/containers/:container_id/videos/:video_id"

  def self.trending(options = {}, &block)
    self.fetch(options.merge(sort: 'trending'), &block)
  end

  def self.recommendations(video_id, options = {}, &block)
    self.fetch(options.merge(recommended_for: video_id), &block)
  end
end
