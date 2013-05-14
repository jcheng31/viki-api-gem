module Viki
  class MusicVideo < Video
    path 'v4/music_videos.json'
    path 'v4/containers/:container_id/music_videos.json'
  end
end
