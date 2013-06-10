class Viki::Subtitle < Viki::Core::Base
  path '/videos/:video_id/subtitles/:language'
  default format: 'srt'
end