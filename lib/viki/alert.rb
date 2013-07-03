class Viki::Alert < Viki::Core::Base
  cacheable
  path "/users/:user_id/alerts"

  def self.unread_count(user_id, &block)
    self.fetch(user_id: user_id, unread: 'true', only_count: 'true', &block)
  end

  def self.unread_count_sync(user_id)
    self.fetch_sync(user_id: user_id, unread: 'true', only_count: 'true')
  end
end
