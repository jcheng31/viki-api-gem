module Viki
  class Country < Viki::Core::Base
    EMPTY = {}
    path 'v4/countries.json'

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
end
