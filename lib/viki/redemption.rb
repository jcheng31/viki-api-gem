class Viki::Redemption < Viki::Core::Base
  cacheable
  path "/users/:user_id/redemptions"
  path "/users/:user_id/redemptions/:gift_code"
end