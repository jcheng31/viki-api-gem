class Viki::Device < Viki::Core::Base
  LINK='link'
  UNLINK='unlink'

  path "/users/:user_id/devices", api_version: 'v5'
  path "/users/:user_id/link",  api_version: 'v5', name: LINK
  path "/users/:user_id/unlink/:device_token", api_version: 'v5', name: UNLINK

  def self.link(user_id, body = {}, &block)
    self.create({user_id: user_id, named_path: LINK}, body, &block)
  end

  def self.unlink(user_id, body = {}, &block)
    device_token = body.delete(:device_token)
    self.destroy({user_id: user_id, device_token: device_token ,named_path: UNLINK}, &block)
  end
end
