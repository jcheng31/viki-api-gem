module Viki
  class Notification < Core::Base
    path "v4/notifications.json"
    path "v4/users/:user_id/notifications.json"

    def self.unread_count(user_id, &block)
      self.fetch(user_id: user_id, unread: 'true', only_count: 'true', &block)
    end

    def self.unread_count_sync(user_id)
      self.fetch_sync(user_id: user_id, unread: 'true', only_count: 'true')
    end
  end
end
