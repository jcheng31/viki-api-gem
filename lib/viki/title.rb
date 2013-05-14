module Viki
  class Title < Core::Base
    path "v4/containers/:container_id/titles.json"
    path "v4/videos/:video_id/titles.json"
  end
end
