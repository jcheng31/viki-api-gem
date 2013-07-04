class Viki::UserSummary < Viki::Core::Base
  cacheable
  path "/users/:id/summary"
end
