class Viki::SubtitleHistory < Viki::Core::Base
  cacheable
  path "/users/:user_id/subtitle_histories"
end
