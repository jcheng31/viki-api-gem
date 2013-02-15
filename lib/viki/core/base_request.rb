module Viki::Core
  class BaseRequest
    class ErrorResponse < RuntimeError
      INVALID_TOKENS = [11, 7402]

      attr_accessor :error, :vcode, :status, :url, :json, :body, :details

      def initialize(body, status, url)
        @body = body
        @status = status
        @url = url
        begin
          @json = Oj.load(@body)
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
    end

    attr_reader :url, :body

    def initialize(url, body = nil)
      @url = url.to_s
      @body = body ? Oj.dump(body, mode: :compat) : nil
    end

    def queue(&block)
      request.tap do |req|
        req.on_complete do |res|
          if is_error?(res)
            error = ErrorResponse.new(res.body, res.code, @url)
            Viki.logger.error(error.to_s)
            raise error if error.invalid_token?
            on_complete error, nil, &block
          else
            on_complete nil, res.body, &block
          end
        end

        Viki.hydra.queue(req)
      end
    end

    def default_headers
      {}.tap do |headers|
        user_ip = Viki.user_ip.call
        headers['X-Forwarded-For'] = user_ip if user_ip
      end
    end

    private

    def is_error?(response)
      !response.success?
    end
  end
end
