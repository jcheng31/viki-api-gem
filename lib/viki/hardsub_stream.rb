module Viki
  class HardsubStream < Viki::Core::Base
    path 'v4/videos/:video_id/hardsubs.json'
    path 'v4/videos/:video_id/hardsubs/:language.json'
  end
end
