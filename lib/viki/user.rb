module Viki
  class User < Viki::Core::Base
    class AuthenticationError
    end

    path '/v4/sessions.json'

    def self.authenticate(username, password, persist = false, &block)
      body = {'username' => username, 'password' => password, 'persist' => persist}
      uri = signed_uri({}, body)
      Viki.logger.info "#{self.name} authenticating #{username} to the API: #{uri}"
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
