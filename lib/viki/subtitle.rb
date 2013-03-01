module Viki
  class Subtitle < Viki::Core::Base
    path 'v4/videos/:video_id/subtitles/:language.srt'
  end
end