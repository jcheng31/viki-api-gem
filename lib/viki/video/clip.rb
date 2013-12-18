class Viki::Clip < Viki::Video
  path "/clips", api_version: "v5"
  path "/containers/:container_id/clips", api_version: "v5"
end