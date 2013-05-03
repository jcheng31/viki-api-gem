module Viki
  class BlockedLanguages < Viki::Core::Base
    path 'v4/containers/:container_id/blocked_languages.json'
  end
end
