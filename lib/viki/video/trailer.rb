class Viki::Trailer < Viki::Video
  path "/trailers", api_version: "v4"
  path "/containers/:container_id/trailers", api_version: "v4"
end
