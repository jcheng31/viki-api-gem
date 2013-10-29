class Viki::Session < Viki::Core::Base
  class AuthenticationError; end
  default api_version: 'v5'
  path "/sessions"
  path "/sessions/:token"

  def self.authenticate(login_id, password, params = {}, &block)
    body = params.merge({'username' => login_id, 'password' => password, persist: false})
    uri = signed_uri({}, body)
    Viki.logger.info "#{self.name} authenticating #{login_id} to the API: #{uri}"
    creator = Viki::Core::Creator.new(uri, body)
    creator.queue &block
  end

  def self.auth_facebook(token, params = {}, &block)
    body = params.merge({'facebook_token' => token, persist: false})
    uri = signed_uri({}, body)
    Viki.logger.info "#{self.name} authenticating facebook token to the API: #{uri}"
    creator = Viki::Core::Creator.new(uri, body)
    creator.queue &block
  end
end