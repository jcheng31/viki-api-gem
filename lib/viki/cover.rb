module Viki
  class Cover < Viki::Core::Base
    path 'v4/containers/:container_id/covers/:language.json'
    path 'v4/containers/:container_id/covers.json'
  end
end
