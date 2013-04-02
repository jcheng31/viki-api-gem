module Viki
  class UserSummary < Viki::Core::Base
    path '/v4/users/:id/summary.json'
  end
end
