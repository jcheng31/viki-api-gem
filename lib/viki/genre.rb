class Viki::Genre < Viki::Core::Base
  path "/:resource/genres"
  # Consumes v4 genres endpoint
  # Available resource are 'movies', 'series', 'music_videos'
  #
  # Usage:
  #
  #   Viki::Genre.fetch(resource: 'movies') do |movies|
  #     # movies => [{"id"=>1, "name"=>"Action & Adventure"}, {"id"=>2, "name"=>"Anime"}, ...  {"id"=>22, "name"=>"Western"}]
  #   end
end