module Viki
  class Artist < Container
    path 'v4/artists.json'
    path 'v4/artists/:artist_id/casts.json'

    def self.casts_for(artist_id, options = {}, &block)
      self.fetch(options.merge(artist_id: artist_id), &block)
    end
  end
end
