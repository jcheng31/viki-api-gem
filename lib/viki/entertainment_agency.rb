class Viki::EntertainmentAgency < Viki::Core::Base
  cacheable
  path '/entertainment_agencies', api_version: "v4"
end
