module Viki::Core
  class Creator < BaseRequest
    def on_complete(error, body, &block)
      parsed_body = Oj.load(body) rescue nil
      block.call Viki::Core::Response.new(error, parsed_body)
    end

    def request
      headers = default_headers.merge({'Content-Type' => "application/json"})
      @request ||= Typhoeus::Request.new url,
                                         body: body,
                                         headers: headers,
                                         method: "post",
                                         forbid_reuse: true
    end
  end
end
