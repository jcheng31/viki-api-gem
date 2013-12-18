class Viki::Movie < Viki::Video
  path "/movies", api_version: "v5"
  path "/films/:container_id/movies", api_version: "v5"
end