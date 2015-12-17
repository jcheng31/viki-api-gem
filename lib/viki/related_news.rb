class Viki::RelatedNews < Viki::Core::Base
  cacheable
  path '/related_news'
  path '/:resource_type/:resource_id/related_news'
end
