class Viki::Description < Viki::Core::Base
  cacheable
  path "/containers/:container_id/descriptions"
  path "/videos/:video_id/descriptions"
end
