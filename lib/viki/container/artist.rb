class Viki::Artist < Viki::Container
  path "/artists"
  path "/artists/:artist_id/casts"

  def self.casts_for(artist_id, options = {}, &block)
    self.fetch(options.merge(artist_id: artist_id), &block)
  end
end