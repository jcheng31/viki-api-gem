class Viki::Like < Viki::Core::Base
  cacheable
  path "/users/:user_id/likes"
end