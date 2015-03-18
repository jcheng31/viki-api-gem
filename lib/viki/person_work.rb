class Viki::PersonRole < Viki::Core::Base
  cacheable
  path '/people/:person_id/works', api_version: "v4"
end
