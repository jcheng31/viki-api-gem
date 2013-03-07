module Viki
  class Subscriber < Core::Base
    path "v4/containers/:resource_id/subscribers.json"
  end
end
