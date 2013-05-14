module Viki
  class Episode < Video
    path 'v4/episodes.json'
    path 'v4/containers/:container_id/episodes.json'
  end
end
