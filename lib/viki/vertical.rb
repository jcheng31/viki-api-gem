class Viki::Vertical < Viki::Core::Base
  path '/verticals', api_version: "v5"
  path '/verticals/:vertical_id/containers', api_version: "v5"
end
