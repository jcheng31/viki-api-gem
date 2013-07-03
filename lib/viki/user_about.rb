class Viki::UserAbout < Viki::Core::Base
  cacheable
  path "/users/:user_id/about"
end
