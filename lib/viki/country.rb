module Viki
  class Country < Viki::Core::Base
    path 'v4/countries.json'

    def self.find(country_code)
      all[country_code]
    end

    def self.codes
      all.keys
    end

    def self.all
      return @countries if defined?(@countries)
      fetch do |response|
        @countries = response.value
      end
      Viki.run
      @countries
    end
  end
end
