module Viki
  class MusicVideo < Video
    path 'v4/music_videos.json'
    path 'v4/container/:container_id/music_videos.json'
  end
end
