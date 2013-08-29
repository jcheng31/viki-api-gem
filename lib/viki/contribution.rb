class Viki::Contribution < Viki::Core::Base
  CANDIDATE='mark_as_candidate'

  cacheable
  path '/containers/:container_id/contributions'
  path '/users/:user_id/contributions'
  path '/users/:user_id/contributions/mark_as_candidate', name: CANDIDATE

  def self.mark_as_candidate(options = {}, &block)
    self.update(options.merge(named_path: CANDIDATE), &block)
  end
end
