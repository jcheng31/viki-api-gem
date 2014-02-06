class Viki::Description < Viki::Core::Base
  path "/containers/:container_id/descriptions"
  path "/containers/:container_id/descriptions/:language_code"
  path "/videos/:video_id/descriptions"
  path "/videos/:video_id/descriptions/:language_code"
end
