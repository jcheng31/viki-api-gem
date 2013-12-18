class Viki::MusicVideo < Viki::Video
  path "/music_videos", api_version: "v5"
  path "/containers/:container_id/music_videos", api_version: "v5"
end