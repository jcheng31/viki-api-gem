module Viki
  class User < Viki::Core::Base
    use_ssl

    path '/v4/users.json'
    path '/v4/users/:full_id/full.json'
  end
end
