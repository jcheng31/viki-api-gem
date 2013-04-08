module Viki
  class Video < Viki::Core::Base
    path "v4/videos.json"
    path "v4/videos/:recommended_for/recommendations.json"
    path "v4/containers/:container_id/videos.json"

    def self.trending(options = {}, &block)
      self.fetch(options.merge(sort: 'trending'), &block)
    end

    def self.recommendations(video_id, options = {}, &block)
      self.fetch(options.merge(recommended_for: video_id), &block)
    end
  end
end
