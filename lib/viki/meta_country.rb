class Viki::MetaCountry < Viki::Core::Base
  EMPTY = {}
  path '/countries2'

  def self.find(country_code)
    all[country_code]
  end

  def self.codes
    all.keys
  end

  def self.all
    return @countries if @countries && @countries != EMPTY
    fetch do |response|
      @countries = response.value || EMPTY
    end
    Viki.run
    @countries
  end
end
