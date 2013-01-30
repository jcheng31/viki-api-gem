module Viki
  class Stream < Viki::Core::Base
    path 'v4/videos/:video_id/streams.json'
  end
end
