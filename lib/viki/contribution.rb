class Viki::Contribution < Viki::Core::Base
  CANDIDATE='mark_as_candidate'
  RECOMMENDATION='recommendation_lists'
  USER_CONTRIBUTION_COUNT='count'

  cacheable
  path '/containers/:container_id/contributions'
  path '/users/:user_id/contributions'
  path '/users/:user_id/contributions/mark_as_candidate', name: CANDIDATE
  path '/contributions/recommendation_lists', name: RECOMMENDATION
  path '/users/:user_id/contributions/count', name: USER_CONTRIBUTION_COUNT

  def self.recommendation_lists(options = {}, &block)
    self.fetch(options.merge(named_path: RECOMMENDATION), &block)
  end

  def self.mark_as_candidate(options = {}, &block)
    self.update(options.merge(named_path: CANDIDATE), &block)
  end

  def self.count(options = {}, &block)
    self.fetch(options.merge(named_path: USER_CONTRIBUTION_COUNT), &block)
  end
end
