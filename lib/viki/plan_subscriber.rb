class Viki::PlanSubscriber < Viki::Core::Base
  cacheable
  path "/plan_subscribers"
  path "/users/:user_id/plans"
  path "/users/:user_id/plans/:plan_id"
end
