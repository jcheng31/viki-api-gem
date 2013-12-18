class Viki::NewsClip < Viki::Video
  path "/news_clips", api_version: "v5"
  path "/containers/:container_id/news_clips", api_version: "v5"
end