Viki API gem
============

This gem gives tools to access the Viki.com API.

Installation
------------

Add the gem in your `Gemfile` and run `bundle`

```ruby
gem "viki-api", require: 'viki'
```

Now you need to configure it. In a Rails project you can create a `viki_api.rb` file in your
initializers folder with the following content:

```ruby
Viki.configure do |c|
  # Required fields
  c.salt = 'your_salt'
  c.app_id = 'your_app_id'
  c.user_ip = -> { 'the IP of your user' }
  c.user_token = -> { 'the token of your user' }

  # Optional
  c.user_country = -> { 'the country of your user' }
  c.logger = Logger.new(STDOUT) # The logger to use from the gem
end
```

Configuration
-------------

* `c.salt` Must contain you salt. Default to `ENV["VIKI_API_SALT"]`. Either in config or using `ENV`, it is **required**.

* `c.app_id` Must contain you application id. Default to `ENV["VIKI_API_APP_ID"]`. Either in config or using `ENV`, it is **required**.

* `c.user_ip` Lambda block returning the IP address of the user. It is put in the header of the requests to the API as `X-FORWARDED-FOR`. **Required**

* `c.user_token` Lambda block returning the session token of the user. **Required**

* `c.user_country` Lambda block returning the country of the user. If not present, will be resolved from his/her IP address. **Optional**

* `c.logger` Instance of `Logger` you want the gem to use. Default to `Logger.new(STDOUT)`. **Optional**

Usage by examples
-----------------

**NOTE:** Remember to run `Viki.run` after fetching.

* Fetch a list of episodes

```ruby
Viki::Episode.fetch do |response|
  puts response.value.inspect
end
```

* Fetch a single episode

```ruby
Viki::Episode.fetch(id: "44699v") do |response|
  puts response.value.inspect
end
```

* Fetch trending movies (videos)

```ruby
Viki::Movie.trending do |response|
  puts response.value.inspect
end
```

* Fetch recommended videos for an episode

```ruby
Viki::Video.recommendations("44699v") do |response|
  puts response.value.inspect
end
```

* Fetch popular TV shows

```ruby
Viki::Series.popular do |response|
  puts response.value.inspect
end
```

* Fetch upcoming TV shows

```ruby
Viki::Series.upcoming do |response|
  puts response.value.inspect
end
```

* Fetch a container cover page

```ruby
Viki::Cover.fetch(container_id: '50c', language: 'en') do |response|
  puts response.value.inspect
end
```

* Subscribe a user to a container

```ruby
Viki::Subscription.create({user_id: user_id}, {'resource_id' => container_id}) do |response|
  puts response.inspect
end
```

* Get language information

```ruby
english = Viki::Language.find('en')
all_language_codes = Viki::Language.codes
```

* Get country information

```ruby
italy = Viki::Country.find('it')
all_country_codes = Viki::Country.codes
```

* Create a user

```ruby
user_attributes = {first_name: "Tester",
                   last_name: "Lee",
                   email: "tester@example.com",
                   language: 'en',
                   password: "123456",
                   password_confirmation: "123456"}
Viki::User.create({}, user_attributes) do |response|
  puts response.inspect
end
```

* Update a user

The `token` and the `id` should belong to the same user

```ruby
user_new_attributes = {first_name: "new first name"}
Viki::User.update({id: user_id}, user_new_attributes) do |response|
  puts response.inspect
end
```

* Fetch user

```ruby
Viki::User.fetch(id: user_id) do |response|
  puts response.inspect
end
```

* Login

```ruby
Viki::Session.authenticate('tester@example.com', 'password') do |response|
  puts response.inspect
end
```

* Logout

```ruby
Viki::Session.destroy(token: user_token) do |response|
  puts response.inspect
end
```

* Validate a token

```ruby
Viki::Session.fetch(token: user_token) do |response|
  puts response.inspect
end
```

* Send reset password

```ruby
Viki::ResetPasswordToken.forgot_password!(user_email) do |response|
  puts response.inspect
end

* Update password from reset password token

```ruby
Viki::ResetPasswordToken.reset_password!(reset_password_token, password, password_confirmation) do |response|
  puts response.inspect
end



Changelog
---------

* 0.0.13
  * Added ResetPasswordToken support
  * Documented usage of Sessions
  * Documented usage of Users
  * Documented usage of ResetPassword tokens

* 0.0.12
  * Fixed X-Forwarded-For issue

* 0.0.11
  * Added Language and Country support.

* 0.0.10
  * User creation goes through https.

* 0.0.9
  * Authentication goes through Session, leaving User for user management.

* 0.0.8
  * Removed caching.
