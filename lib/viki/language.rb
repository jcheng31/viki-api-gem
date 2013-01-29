module Viki
  class Language < Viki::Core::Base
    EMPTY = {}
    path 'v4/languages.json'

    def self.find(language_code)
      all[language_code]
    end

    def self.codes
      all.keys
    end

    def self.all
      return @languages if @languages && @languages != EMPTY
      fetch do |response|
        @languages = response.value || EMPTY
      end
      Viki.run
      @languages
    end
  end
end
