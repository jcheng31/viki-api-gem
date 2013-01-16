module Viki::Core
  class Response < Struct.new(:error, :value, :fetcher)
  end
end
