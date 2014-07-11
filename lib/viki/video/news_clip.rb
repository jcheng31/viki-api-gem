class Viki::NewsClip < Viki::Video
  path "/news_clips", api_version: "v4"
  path "/containers/:container_id/news_clips", api_version: "v4"
end
