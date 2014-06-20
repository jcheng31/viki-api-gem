class Viki::ContainerPeople < Viki::Core::Base
  cacheable
  path '/containers/:id/people'
end
