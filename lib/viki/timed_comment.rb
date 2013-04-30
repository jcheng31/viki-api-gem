module Viki
  class TimedComment < Core::Base
    path "v4/videos/:id/timed_comments.json"
    path "v4/videos/:id/timed_comments/:language.json"
  end
end
