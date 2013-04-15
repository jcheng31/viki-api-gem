module Viki
  class SubtitleCompletion < Viki::Core::Base
    path 'v4/videos/:video_id/subtitle_completions.json'
  end
end
