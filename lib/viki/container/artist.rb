class Viki::Artist < Viki::Container
  path "/artists"
  path "/artists/:artist_id/casts", api_version: "v4"

  def self.casts_for(artist_id, options = {}, &block)
    self.fetch(options.merge(artist_id: artist_id), &block)
  end
end
