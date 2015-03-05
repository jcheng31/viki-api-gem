module Viki::Core
  class Cache
    TOKEN_FIELD = 'token'
    IGNORED_PARAMS = Set.new(['t', 'sig', TOKEN_FIELD])
    TOKEN_ROLE_SEPARATOR='_'

    def self.generate_key(url)
      parsed_url = Addressable::URI.parse(url)
      cache_key = parsed_url.path
      query_values = parsed_url.query_values
      if query_values
        token = query_values[TOKEN_FIELD]
        user_role = 0
        if token
          rindex_token = token.rindex(TOKEN_ROLE_SEPARATOR)
          user_role = rindex_token.nil? ? 0 : token[rindex_token + 1, token.length]
        end
        cache_key += "-@role=#{user_role}"

        sorted_keys = query_values.keys.sort
        sorted_keys.each do |key|
          next if IGNORED_PARAMS.include?(key)
          cache_key += "-#{key}=#{query_values[key]}"
        end
      end
      "#{Viki.cache_ns}.#{cache_key}"
    end
  end
end