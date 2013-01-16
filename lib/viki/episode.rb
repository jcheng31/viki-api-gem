module Viki
  class Episode < Video
    path 'v4/episodes.json'
    path 'v4/container/:container_id/episodes.json'
  end
end
