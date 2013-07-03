class Viki::Subscription < Viki::Core::Base
  cacheable
  path "/users/:user_id/subscriptions"
  path "/containers/:container_id/subscriptions", manage: true
end
