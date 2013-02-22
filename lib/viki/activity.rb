module Viki
  class Activity < Viki::Core::Base
    path "v4/users/:user_id/activities.json"
  end
end
