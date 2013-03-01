module Viki
  class Message < Core::Base
    path "v4/users/:user_id/threads/:thread_id/messages.json"
  end
end
