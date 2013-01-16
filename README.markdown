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
  c.cache = YOUR_REDIS_INSTANCE
  c.cache_ns = 'namespace_for_your_redis_cache_keys'
  c.cache_time = 30 # seconds to cache
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

* `c.cache` Redis instance where the gem will store cached responses from the API. Default to nil. **Optional**

* `c.cache_ns` Namespace for the cache keys stored in Redis. Default to `viki-api-gem-cache`. **Optional**

* `c.cache_time` Seconds to cache responses from the API. Default to 30. **Optional**

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

* Login a user

```ruby
Viki::User.authenticate(username, password, persist_longer) do |response|
  puts response.inspect
end
```

* Login a user using Facebook

```ruby
Viki::User.auth_facebook(fb_token) do |response|
  puts response.inspect
end
```

* Subscribe a user to a container

```ruby
Viki::Subscription.create({user_id: user_id}, {'resource_id' => container_id}) do |response|
  puts response.inspect
end
```


Development
-----------

Make sure you have bundler >= 1.2.

To develop with a local copy of the viki-api-gem, run the following command:

```ruby
bundle config local.viki-api-gem ~/workspace/viki_api_gem/
```

This will use your local copy of the gem instead of the remote one.
