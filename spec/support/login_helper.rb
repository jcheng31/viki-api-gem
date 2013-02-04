module LoginHelper
  def login_as(email, password, &cb)
    user_id = nil
    Viki::Session.authenticate(email, password) do |response|
      data = response.value
      token = data["token"]
      Viki.stub(:user_token) { lambda { token } }
      user_id = data["user"]["id"]
      cb.call(user_id) if block_given?
    end
    Viki.run unless block_given?
    user_id
  end
end
