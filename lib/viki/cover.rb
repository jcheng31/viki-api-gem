class Viki::Cover < Viki::Core::Base
  cacheable
  path "/containers/:container_id/covers/:language"
  path "/containers/:container_id/covers"
end
