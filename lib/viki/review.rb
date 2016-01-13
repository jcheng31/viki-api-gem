class Viki::Review < Viki::Core::Base
  cacheable
  LANGUAGES = 'languages'

  path '/containers/:container_id/reviews'
  path '/reviews'
  path '/reviews/languages', name: LANGUAGES
  path '/users/:user_id/reviews'
  path '/reviews/:review_id'

  def self.languages(options = {}, &block)
    self.fetch(options.merge(named_path: LANGUAGES), &block)
  end

  def self.create_review(resource_id, body = {}, &block)
    self.create({resource_id: resource_id}, body, &block)
  end

  def self.update_review(review_id, body = {}, &block)
    self.update({review_id: review_id}, body, &block)
  end

  def self.delete_review(review_id, &block)
    self.destroy({review_id: review_id}, &block)
  end
end
