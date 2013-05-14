module Viki
  class Description < Core::Base
    path "v4/containers/:container_id/descriptions.json"
    path "v4/videos/:video_id/descriptions.json"
  end
end
