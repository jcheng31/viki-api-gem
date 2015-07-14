class Viki::EntertainmentAgency < Viki::Core::Base
  cacheable
  path '/people/entertainment_agencies', api_version: "v4"
end