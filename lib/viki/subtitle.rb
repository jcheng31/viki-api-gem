class Viki::Subtitle < Viki::Core::Base
  cacheable
  path '/videos/:video_id/subtitles/:language'
  default format: 'srt'
end
