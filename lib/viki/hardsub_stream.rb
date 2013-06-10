class Viki::HardsubStream < Viki::Core::Base
  path "/videos/:video_id/hardsubs"
  path "/videos/:video_id/hardsubs/:language"
end