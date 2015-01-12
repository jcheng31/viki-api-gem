# Fetch available countries particular for that resource type
#
# Usage:
#
#   Viki::CountryByResource.fetch(resource: 'movies') do |movies|
#   end
#
#   resource can be that value of "series","films","news",episodes","movies","clips","music_videos","news_clips""

class Viki::CountryByResource < Viki::Core::Base
  path '/:resource/countries'
end
