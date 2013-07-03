class Viki::Contribution < Viki::Core::Base
  cacheable
  path '/containers/:container_id/contributions'
  path '/users/:user_id/contributions'
end
