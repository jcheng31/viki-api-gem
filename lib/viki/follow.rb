class Viki::Follow < Viki::Core::Base
  cacheable
  path '/users/:current_user/followings'
  path '/users/:user_id/followers'

  def self.followings(current_user_id, options = {}, &block)
    self.fetch(options.merge(current_user: current_user_id), &block)
  end

  def self.followers(user, options = {}, &block)
    self.fetch(options.merge(user_id: user), &block)
  end
end