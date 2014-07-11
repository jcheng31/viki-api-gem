class Viki::Episode < Viki::Video
  path "/episodes", api_version: "v4"
  path "/containers/:container_id/episodes", api_version: "v4"
end
