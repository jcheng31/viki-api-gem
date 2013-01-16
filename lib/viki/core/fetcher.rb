module Viki::Core
  class Fetcher < BaseRequest
    attr_accessor :count, :more

    PAGE_REGEX = /page=(\d+)/
    TOKEN_FIELD = "token"
    IGNORED_PARAMS = ['t', 'sig', TOKEN_FIELD]

    def queue(&block)
      super && return unless Viki.cache

      cached = Viki.cache.get(cache_key(url))
      if cached
        block.call(nil, get_content(Oj.load(cached)))
      else
        super
      end
    end

    def on_complete(error, body, &block)
      if error
        block.call Viki::Core::Response.new(error, nil, self)
      else
        if Viki.cache
          Viki.cache.set(cache_key(url), body)
          Viki.cache.expire(cache_key(url), Viki.cache_seconds)
        end
        block.call Viki::Core::Response.new(nil, get_content(Oj.load(body)), self)
      end
    end


    def request
      Typhoeus::Request.new url,
                            headers: default_headers,
                            method: "get"
    end

    private
    def get_content(json)
      if is_list?(json)
        @count = json["count"]
        @more = json["more"] if json.has_key?('more')
        @more = !!json["pagination"]["next"] if json.has_key?('pagination')
        json["response"]
      else
        json
      end
    end

    def is_list?(value)
      return false unless value.is_a?(Hash)
      value.has_key?("response")
    end

    def cache_key(url)
      parsed_url = Addressable::URI.parse(url)
      cache_key = parsed_url.path

      if parsed_url.query_values
        user_role = parsed_url.query_values[TOKEN_FIELD].to_s.split("|")[1]
        cache_key += "-@role=#{user_role}" if user_role

        parsed_url.query_values.
          reject { |k, _| IGNORED_PARAMS.include?(k) }.
          to_a.
          sort_by { |(k, _)| k }.
          each do |k, v|
          cache_key += "-#{k}=#{v}"
        end
      end
      "#{Viki.cache_hash_key}.#{cache_key}"
    end
  end
end
