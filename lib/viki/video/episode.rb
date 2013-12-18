class Viki::Episode < Viki::Video
  path "/episodes", api_version: "v5"
  path "/containers/:container_id/episodes", api_version: "v5"
end