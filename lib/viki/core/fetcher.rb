require 'set'
require 'viki/core/cache'

module Viki::Core
  class Fetcher < BaseRequest
    attr_accessor :count, :more, :details

    PAGE_REGEX = /page=(\d+)/

    def queue(&block)
      Viki.logger.info "[API Request] [Cacheable] [#{Viki.user_ip[]}] #{url} "

      super && return if url.include?("nocache=true")
      super && return unless Viki.cache && !cacheable.empty?

      cached = Viki.cache.get(cache_key)
      if cached
        begin
          parsed_body = Oj.load(cached, mode: :compat, symbol_keys: false)
        rescue
          Viki.logger.info "Couldn't parse json. Body: #{@body.to_s}. Object: #{self}"
        end
        if parsed_body
          block.call Viki::Core::Response.new(nil, get_content(parsed_body), self)
        else
          error = Viki::Core::ErrorResponse.new(body, 0, url)
          Viki.logger.error(error.to_s)
          block.call Viki::Core::Response.new(error, nil, self)
        end
      else
        super
      end
    end

    def on_complete(error, body, headers, &block)
      if error
        block.call Viki::Core::Response.new(error, nil, self)
      else
        if body
          if Viki.cache && !cacheable.empty?
            cacheSeconds = cacheable[:cache_seconds]
            # Respect timing set in Cache-Control header for stuff that's public
            if headers.respond_to?(:has_key?) && headers.has_key?("Cache-Control")
              cacheHeaderParts = headers["Cache-Control"].split(",").map { |s| s.strip }
              if cacheHeaderParts.include?("public")
                maxAgeRegex = %r{^max-age=\d+$}
                maxAgeList = cacheHeaderParts.drop_while { |x| x !~ maxAgeRegex }
                if maxAgeList.length > 0
                  cacheSeconds = %r{^max-age=(\d+)$}.match(maxAgeList[0])[1].to_i
                end
              end
            end
            Viki.cache.setex(cache_key, cacheSeconds, Oj.dump(body, mode: :compat))
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
                            timeout: (Viki.timeout_seconds)
    end

    private
    def get_content(json)
      if is_list?(json)
        @count = json["count"]
        @more = json["more"] if json.has_key?('more')
        @more = !!json["pagination"]["next"] if json.has_key?('pagination')
        @details = json["details"]
        json["response"]
      else
        json
      end
    end

    def is_list?(value)
      return false unless value.is_a?(Hash)
      value.has_key?("response")
    end

    def cache_key
      @cache_key ||= Cache.generate_key(url)
    end
  end
end
