module Viki
  class ResetPasswordToken < Viki::Core::Base
    path '/v4/reset_password_tokens.json'

    def self.forgot_password!(email, &block)
      self.create({}, {'email' => email}, &block)
    end

    def self.reset_password!(reset_password_token, password, password_confirmation, &block)
      options = {'reset_password_token' => reset_password_token,
                 'password' => password,
                 'password_confirmation' => password_confirmation}
      self.update({}, options, &block)
    end
  end
end
