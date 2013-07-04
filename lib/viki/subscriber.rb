class Viki::Subscriber < Viki::Core::Base
  cacheable
  path "/containers/:resource_id/subscribers"
end
