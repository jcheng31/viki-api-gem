class Viki::Title < Viki::Core::Base
  path "/containers/:container_id/titles"
  path "/containers/:container_id/titles/:language_code"
  path "/videos/:video_id/titles"
  path "/videos/:video_id/titles/:language_code"
end
