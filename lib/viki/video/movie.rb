class Viki::Movie < Viki::Video
  path "/movies", api_version: "v4"
  path "/films/:container_id/movies", api_version: "v4"
end
