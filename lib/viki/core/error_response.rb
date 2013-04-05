module Viki::Core

  class ErrorResponse < RuntimeError
    INVALID_TOKENS = [11, 7402]

    attr_accessor :error, :vcode, :status, :url, :json, :body, :details

    def initialize(body, status, url)
      @body = body
      @status = status.to_i
      @url = url
      begin
        @json = Oj.load(@body.to_s, mode: :compat, symbol_keys: false)
        @error = @json["error"]
        @vcode = @json["vcode"].to_i
        @details = @json["details"]
      rescue Oj::ParseError
        #ignore
      end
    end

    def to_s
      "Got an error response from the API. URL: '%s'; Status: %s; VCode: %s, Error: %s, Details: %s" %
        [url, status, vcode, error, details.inspect]
    end

    def invalid_token?
      INVALID_TOKENS.include? @vcode
    end

    def not_found?
      @status == 404
    end

    def client_error?
      @status >= 400 && @status < 500
    end

    def server_error?
      @status >= 500 && @status < 600
    end
  end
end
