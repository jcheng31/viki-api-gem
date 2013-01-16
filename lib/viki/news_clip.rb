module Viki
  class NewsClip < Video
    path "v4/news_clips.json"
    path "v4/container/:container_id/news_clips.json"
  end
end
