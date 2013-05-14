module Viki
  class Clip < Video
    path 'v4/clips.json'
    path 'v4/containers/:container_id/clips.json'
  end
end
