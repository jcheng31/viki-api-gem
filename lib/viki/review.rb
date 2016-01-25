class Viki::Review < Viki::Core::Base
  cacheable
  LANGUAGES = 'languages'
  VOTE_PATCH = 'vote_patch'

  path '/containers/:container_id/reviews'
  path '/reviews'
  path '/reviews/languages', name: LANGUAGES
  path '/users/:user_id/reviews'
  path '/reviews/:review_id'
  path '/reviews/:review_id/votes', name: VOTE_PATCH

  def self.languages(options = {}, &block)
    self.fetch(options.merge(named_path: LANGUAGES), &block)
  end

  def self.create_review(resource_id, body = {}, &block)
    self.create({resource_id: resource_id}, body, &block)
  end

  def self.update_review(review_id, body = {}, &block)
    self.update({review_id: review_id}, body, &block)
  end

  def self.update_like(review_id, body = {}, &block)
    self.patch({review_id: review_id}.merge(named_path: VOTE_PATCH), body, &block)
  end

  def self.delete_review(review_id, &block)
    self.destroy({review_id: review_id}, &block)
  end
end
