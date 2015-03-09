class Viki::RelationType < Viki::Core::Base
  cacheable
  path "/relation-types", api_version: "v4"
end
