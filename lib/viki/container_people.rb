class Viki::ContainerPeople < Viki::Core::Base
  cacheable
  path '/containers/:id/people'
  path '/containers/:id/people-involved/:language', api_version: "v4"
end
