class Viki::PersonRole < Viki::Core::Base
  cacheable
  path "/person-roles", api_version: "v4"
end
