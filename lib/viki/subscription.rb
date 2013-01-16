module Viki
  class Subscription < Viki::Core::Base
    path "v4/users/:user_id/subscriptions.json"
  end
end
