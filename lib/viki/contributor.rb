class Viki::Contributor < Viki::Core::Base
  CONTRIBUTOR_COUNT = 'count'
  CONTRIBUTOR_META = 'meta'

  path '/contributors/:user_id/count', name: CONTRIBUTOR_COUNT
  path '/contributors/:user_id/meta', name: CONTRIBUTOR_META

  def self.fetch_count(options = {}, &block)
    self.fetch(options.merge(named_path: CONTRIBUTOR_COUNT), &block)
  end

  def self.fetch_meta(options = {}, &block)
    self.fetch(options.merge(named_path: CONTRIBUTOR_META), &block)
  end

  def self.update_meta(options = {}, &block)
    self.update(options.merge(named_path: CONTRIBUTOR_META), &block)
  end
end
