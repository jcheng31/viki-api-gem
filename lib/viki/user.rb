module Viki
  class User < Viki::Core::Base
    use_ssl

    path '/v4/users.json'
  end
end
