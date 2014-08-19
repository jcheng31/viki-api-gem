class Viki::Redemption < Viki::Core::Base
  GIFT_CARD_INFO = 'gift_card_info'

  cacheable
  path "/users/:user_id/redemptions"
  path "/users/:user_id/redemptions/:gift_code"
  path "/users/:user_id/redemptions/gift_card_info", name: GIFT_CARD_INFO

  def self.gift_card_info(options = {})
    self.fetch_sync(options.merge(named_path: GIFT_CARD_INFO))
  end
end