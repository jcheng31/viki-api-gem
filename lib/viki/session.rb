class Viki::Session < Viki::Core::Base
  class AuthenticationError; end


  def self.fetch(url_options = {}, &block)
    path "/sessions", api_version: 'v5'
    path "/sessions/:token", api_version: 'v5'
    super
  end

  def self.fetch_sync(url_options = {}, &block)
    path "/sessions", api_version: 'v5'
    path "/sessions/:token", api_version: 'v5'
    super
  end

  def self.authenticate(login_id, password, params = {}, &block)
    path "/sessions", api_version: 'v5'
    body = params.merge({'username' => login_id, 'password' => password, persist: false})
    uri = signed_uri({}, body)
    Viki.logger.info "#{self.name} authenticating #{login_id} to the API: #{uri}"
    creator = Viki::Core::Creator.new(uri, body)
    creator.queue &block
  end

  def self.auth_facebook(token, params = {}, &block)
    path "/sessions", api_version: 'v5'
    body = params.merge({'facebook_token' => token, persist: false})
    uri = signed_uri({}, body)
    Viki.logger.info "#{self.name} authenticating facebook token to the API: #{uri}"
    creator = Viki::Core::Creator.new(uri, body)
    creator.queue &block
  end

  def self.update_sync(url_options = {}, body = {})
    path "/sessions/:token", api_version: 'v4'
    super
  end

  def self.update(url_options = {}, body = {}, &block)
    path "/sessions/:token", api_version: 'v4'
    super
  end
end