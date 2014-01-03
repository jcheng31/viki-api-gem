module Viki::Core
  class BaseRequest
    attr_reader :url, :body, :cacheable

    JSON_FORMAT = "json"

    def initialize(url, body = nil, format="json", cache = {})
      @cacheable = cache
      @url = url.to_s
      @format = format
      @body = body ? Oj.dump(body, mode: :compat) : nil
    end

    def queue(&block)
      request.tap do |req|
        req.on_complete do |res|
          Viki.logger.info "[API Request] [Responded] [#{Viki.user_ip[]}] #{@url} #{res.time}s"
          if is_error?(res)
            if res.timed_out?
              error = Viki::Core::TimeoutErrorResponse.new(@url)
            else
              error = Viki::Core::ErrorResponse.new(res.body, res.code, @url)
            end

            Viki.logger.error(error.to_s)
            raise error if error.invalid_token?
            on_complete error, nil, &block
          else
            if @format == JSON_FORMAT
              begin
                parsed_body = Oj.load(res.body, mode: :compat, symbol_keys: false)
                on_complete nil, parsed_body, &block
              rescue
                Viki.logger.info "Couldn't parse json. Body: #{@body.to_s}. Response body: #{res.body.to_s} Object: #{self}"
                error = Viki::Core::ErrorResponse.new(res.body, 0, @url)
                on_complete error, nil, &block
              end
            else
              on_complete nil, res.body, &block
            end
          end
        end

        Viki.hydra.queue(req)
      end
    end

    def default_headers(params_hash = {})
      params_hash.tap do |headers|
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
