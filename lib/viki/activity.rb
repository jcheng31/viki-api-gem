class Viki::Activity < Viki::Core::Base
  cacheable
  path "/activities"
  path "/users/:user_id/activities"
end
