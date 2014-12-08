class Viki::RecentActivity < Viki::Core::Base
  cacheable
  path "/users/:user_id/recent_activities"
end
