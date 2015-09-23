class Viki::Image < Viki::Core::Base
  path "/images/:path/:resource_id/:type", api_version: "v4"
  path "/images"
end
