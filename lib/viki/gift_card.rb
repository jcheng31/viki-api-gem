class Viki::GiftCard < Viki::Core::Base
  SEND_EMAIL = 'send_email'

  cacheable
  path "/gift_cards"
  path "/gift_cards/:gift_code"
  path "/gift_cards/:gift_code/send_email", name: SEND_EMAIL

  def self.send_email(options = {}, body={}, &block)
    self.create(options.merge(named_path: SEND_EMAIL), body, &block)
  end
end
