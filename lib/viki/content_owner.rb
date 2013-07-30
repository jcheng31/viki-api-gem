class Viki::ContentOwner < Viki::Core::Base
  cacheable
  path '/content_owners'
  path '/content_owners/:containers_for/containers'
end
