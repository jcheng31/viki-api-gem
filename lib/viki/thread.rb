class Viki::Thread < Viki::Core::Base
  path "/users/:user_id/threads"

  def self.unread_count(user_id, &block)
    self.fetch(user_id: user_id, type: 'inbox', unread: 'true', only_count: 'true', &block)
  end

  def self.unread_count_sync(user_id)
    self.fetch_sync(user_id: user_id, type: 'inbox', unread: 'true', only_count: 'true')
  end
end