module Viki
  class UnreadCount < Core::Base
    path "v4/users/:user_id/threads/unread_count.json"
  end
end
