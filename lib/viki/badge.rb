class Viki::Badge < Viki::Core::Base
  path "/badges", api_version: 'v5'
  path "/users/:user_id/badges", api_version: 'v5'
end
