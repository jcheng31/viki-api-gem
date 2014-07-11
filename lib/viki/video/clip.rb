class Viki::Clip < Viki::Video
  path "/clips", api_version: "v4"
  path "/containers/:container_id/clips", api_version: "v4"
end
