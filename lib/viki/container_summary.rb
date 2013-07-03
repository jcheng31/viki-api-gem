class Viki::ContainerSummary < Viki::Core::Base
  cacheable
  path '/containers/:id/summary'
end
