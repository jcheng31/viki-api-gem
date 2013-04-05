module Viki::Core
  class BaseRequest
    attr_reader :url, :body

    def initialize(url, body = nil)
      @url = url.to_s
      @body = body ? Oj.dump(body, mode: :compat) : nil
    end

    def queue(&block)
      request.tap do |req|
        req.on_complete do |res|
          if is_error?(res)
            error = Viki::Core::ErrorResponse.new(res.body, res.code, @url)
            Viki.logger.error(error.to_s)
            raise error if error.invalid_token?
            on_complete error, nil, &block
          else
            parsed_body = Oj.load(res.body, mode: :compat, symbol_keys: false) rescue nil
            on_complete nil, parsed_body || res.body, &block
          end
        end

        Viki.hydra.queue(req)
      end
    end

    def default_headers
      {}.tap do |headers|
        headers['User-Agent'] = 'viki'
        headers['Content-Type'] = 'application/json'
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
