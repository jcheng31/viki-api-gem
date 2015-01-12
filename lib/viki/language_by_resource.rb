# Fetch available languages particular for that resource type
#
# Usage:
#
#   Viki::LanguageByResource.fetch(resource: 'movies') do |movies|
#   end
class Viki::LanguageByResource < Viki::Core::Base
  path '/:resource/languages'
end