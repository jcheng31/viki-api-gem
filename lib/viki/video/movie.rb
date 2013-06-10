class Viki::Movie < Viki::Video
  path "/movies"
  path "/films/:container_id/movies"
end