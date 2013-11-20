class Viki::GiftCard < Viki::Core::Base
  cacheable
  path "/gift_cards"
  path "/gift_cards/:gift_code"
end
