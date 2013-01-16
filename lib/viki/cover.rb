module Viki
  class Cover < Viki::Core::Base
    path 'v4/containers/:container_id/covers/:language.json'
  end
end
