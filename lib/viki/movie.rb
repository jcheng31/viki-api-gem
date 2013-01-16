module Viki
  class Movie < Video
    path 'v4/movies.json'
    path 'v4/films/:container_id/movies.json'
  end
end
