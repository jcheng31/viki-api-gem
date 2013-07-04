# Fetch available countries particular for that resource type 
#
# Usage:
#
#   Viki::CountryByResource.fetch(resource: 'movies') do |movies|
#   end
class Viki::CountryByResource < Viki::Core::Base
  path '/:resource/countries'
end