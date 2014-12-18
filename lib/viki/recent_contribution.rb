class Viki::RecentContribution < Viki::Core::Base
  cacheable
  path "/users/:user_id/recent_contributions"
end
