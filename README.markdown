Viki API gem
============

This gem gives tools to access the Viki.com API.

Installation
------------

Add the gem in your `Gemfile` and run `bundle`

```
gem "viki-api", require: 'viki'
```

Now you need to configure it. In a Rails project you can create a `viki_api.rb` file in your
initializers folder with the following content:

```
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

Usage
-----

WIP

Development
-----------

Make sure you have bundler >= 1.2.

To develop with a local copy of the viki-api-gem, run the following command:

```
bundle config local.viki-api-gem ~/workspace/viki_api_gem/
```

This will use your local copy of the gem instead of the remote one.
