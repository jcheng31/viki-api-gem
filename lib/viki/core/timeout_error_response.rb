module Viki::Core

  class TimeoutErrorResponse < ErrorResponse
    TIMEOUT_ERROR_CODE=408

    def initialize(url)
      @status = TIMEOUT_ERROR_CODE
      @url = url
      @error = :timeout
      @vcode = TIMEOUT_ERROR_CODE
    end

    def to_s
      "Got an error response from the API. URL: '%s'; Status: %s; VCode: %s, Error: %s" %
        [url, status, vcode, error]
    end

    def timeout?
      true
    end
  end
end
