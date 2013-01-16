module Viki
  class Clip < Video
    path 'v4/clips.json'
    path 'v4/container/:container_id/clips.json'
  end
end
