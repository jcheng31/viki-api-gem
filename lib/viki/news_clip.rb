module Viki
  class NewsClip < Video
    path "v4/news_clips.json"
    path "v4/containers/:container_id/news_clips.json"
  end
end
