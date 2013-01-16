module Viki::Core
  class Destroyer < BaseRequest
    def on_complete(error, body, &block)
      parsed_body = Oj.load(body) rescue nil
      block.call Viki::Core::Response.new(error, parsed_body)
    end

    def request
      @request ||= Typhoeus::Request.new url,
                                         headers: default_headers,
                                         method: "delete"
    end
  end
end
