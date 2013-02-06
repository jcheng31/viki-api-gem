module Viki::Core
  class Fetcher < BaseRequest
    attr_accessor :count, :more

    PAGE_REGEX = /page=(\d+)/
    TOKEN_FIELD = "token"
    IGNORED_PARAMS = ['t', 'sig', TOKEN_FIELD]

    def on_complete(error, body, &block)
      if error
        block.call Viki::Core::Response.new(error, nil, self)
      else
        parsed_body = Oj.load(body) rescue nil
        if parsed_body
          block.call Viki::Core::Response.new(nil, get_content(parsed_body), self)
        else
          error = ErrorResponse.new(body, 0, url)
          Viki.logger.error(error.to_s)
          block.call Viki::Core::Response.new(error, nil, self)
        end
      end
    end


    def request
      Typhoeus::Request.new url,
                            headers: default_headers,
                            method: "get",
                            forbid_reuse: true
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

  end
end
