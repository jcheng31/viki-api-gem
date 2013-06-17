class Viki::Subscription < Viki::Core::Base
  path "/users/:user_id/subscriptions"
  path "/containers/:container_id/subscriptions"
end