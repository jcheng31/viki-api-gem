module Viki
  class UserAbout < Viki::Core::Base
    path '/v4/users/:user_id/about.json'
  end
end
