class Viki::MusicVideo < Viki::Video
  path "/music_videos", api_version: "v4"
  path "/containers/:container_id/music_videos", api_version: "v4"
end
