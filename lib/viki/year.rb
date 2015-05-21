class Viki::Year < Viki::Core::Base
  cacheable
  path '/containers/years', api_version: "v4"
end