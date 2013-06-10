class Viki::ResetPasswordToken < Viki::Core::Base
  path "/reset_password_tokens"

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