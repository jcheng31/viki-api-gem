module Viki::Core
  class Fetcher < BaseRequest
    attr_accessor :count, :more

    PAGE_REGEX = /page=(\d+)/
    TOKEN_FIELD = "token"
    IGNORED_PARAMS = ['t', 'sig', TOKEN_FIELD]

    def queue(&block)
      super && return unless cacheable && Viki.cache

      cached = Viki.cache.get(cache_key(url))
      if cached
        parsed_body = Oj.load(cached, mode: :compat, symbol_keys: false) rescue nil
        if parsed_body
          block.call Viki::Core::Response.new(nil, parsed_body, self)
        else
          error = Viki::Core::ErrorResponse.new(body, 0, url)
          Viki.logger.error(error.to_s)
          block.call Viki::Core::Response.new(error, nil, self)
        end
      else
        super
      end
    end

    def on_complete(error, body, &block)
      if error
        block.call Viki::Core::Response.new(error, nil, self)
      else
        if body
          if cacheable && Viki.cache
            Viki.cache.setex(cache_key(url), Viki.cache_seconds, Oj.dump(get_content(body), mode: :compat))
          end
          block.call Viki::Core::Response.new(nil, get_content(body), self)
        else
          error = Viki::Core::ErrorResponse.new(body, 0, url)
          Viki.logger.error(error.to_s)
          block.call Viki::Core::Response.new(error, nil, self)
        end
      end
    end

    def request
      Typhoeus::Request.new url,
                            headers: default_headers,
                            method: "get",
                            # forbid_reuse: true,
                            timeout: (Viki.timeout_seconds * 1000)
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
        token = parsed_url.query_values[TOKEN_FIELD]
        user_role = token.nil? ? 0 : token[-1, 1]
        cache_key += "-@role=#{user_role}" if user_role

        parsed_url.query_values.
          reject { |k, _| IGNORED_PARAMS.include?(k) }.
          to_a.
          sort_by { |(k, _)| k }.
          each do |k, v|
          cache_key += "-#{k}=#{v}"
        end
      end
      "#{Viki.cache_ns}.#{cache_key}"
    end
  end
end
