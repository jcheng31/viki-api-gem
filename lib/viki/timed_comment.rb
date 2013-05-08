module Viki
  class TimedComment < Core::Base
    path "v4/videos/:id/timed_comments.json"
    path "v4/videos/:id/timed_comments/:language.json"
    path "v4/videos/:id/timed_comments/:timed_comment_id.json"
  end
end
