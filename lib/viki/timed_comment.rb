class Viki::TimedComment < Viki::Core::Base
  cacheable
  path "/videos/:id/timed_comments"
  path "/videos/:id/timed_comments/:language"
  path "/videos/:id/timed_comments/:timed_comment_id"
end
