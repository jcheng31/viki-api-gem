module Viki
  class Contribution < Viki::Core::Base
    path 'v4/containers/:container_id/contributions.json'
    path 'v4/videos/:video_id/contributions.json'
  end
end
