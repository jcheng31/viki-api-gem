module Viki
  class Session < Viki::Core::Base
    class AuthenticationError
    end

    path '/v4/sessions.json'
    path '/v4/sessions/:token.json'

    def self.authenticate(login_id, password, persist = false, &block)
      body = {'login_id' => login_id, 'password' => password, 'persist' => persist}
      uri = signed_uri({}, body)
      Viki.logger.info "#{self.name} authenticating #{login_id} to the API: #{uri}"
      creator = Viki::Core::Creator.new(uri, body)
      creator.queue &block
    end

    def self.auth_facebook(token, persist = false, &block)
      body = {'facebook_token' => token, 'persist' => persist}
      uri = signed_uri({}, body)
      Viki.logger.info "#{self.name} authenticating facebook token to the API: #{uri}"
      creator = Viki::Core::Creator.new(uri, body)
      creator.queue &block
    end
  end
end
