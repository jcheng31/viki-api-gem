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
  c.cache = YOUR_REDIS_INSTANCE
  c.cache_ns = 'namespace_for_your_redis_cache_keys'
  c.cache_seconds = 5 # seconds to cache
  c.logger = Logger.new(STDOUT) # The logger to use from the gem
  c.timeout_seconds = 30 # The timeout for the requests.
end
```

Configuration
-------------

* `c.salt` Must contain your salt. Default to `ENV["VIKI_API_SALT"]`. Either in config or using `ENV`, it is **required**.

* `c.app_id` Must contain your application id. Default to `ENV["VIKI_API_APP_ID"]`. Either in config or using `ENV`, it is **required**.

* `c.user_ip` Lambda block returning the IP address of the user. It is put in the header of the requests to the API as `X-FORWARDED-FOR`. **Required**

* `c.user_token` Lambda block returning the session token of the user. **Required**

* `c.logger` Instance of `Logger` you want the gem to use. Default to `Logger.new(STDOUT)`. **Optional**

* `c.timeout_seconds` Amount of timeout seconds for the requests. If a request takes longer, it will return an error

* `c.timeout_seconds_post` Amount of timeout seconds specifically for POST and PUT request. If a request takes longer, it will return an error

* `c.cache` =  Redis instance where the gem will store cached responses from the API. Default to nil. **Optional**

* `c.cache_ns` Namespace for the cache keys stored in Redis. Default to `viki-api-gem-cache`. **Optional**

*  `c.cache_seconds` Seconds to cache responses from the API. Default to 5. **Optional**

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

* Fetch Subtitles

```ruby
Viki::Subtitle.fetch(video_id: "44699v", language: "en") do |response|
  puts response.inspect  # SRT format
end
Viki::Subtitle.fetch(video_id: "44699v", language: "en", format: 'json') do |response|
  puts response.inspect  # JSON format
end
```

* Fetch Subtitle_completion

```ruby
Viki::SubtitleCompletion.fetch(video_ids: "44699v,44700v") do |response|
  puts response.inspect
end
```

* Fetch Subtitle_history

```ruby
Viki::SubtitleHistory.fetch(user_id: "1u") do |response|
  puts response.inspect
end
```

* Block languages

```ruby
Viki::BlockedLanguages.fetch(container_id: '5269c') do |response|
  puts response.inspect
end
Viki::BlockedLanguages.create({ container_id: '5269c'}, { 'languages' => 'tr,vi' }) do |response|
  puts response.inspect
end
```

* Fetch streams for a video

```ruby
Viki::Stream.fetch(video_id: '44699v') do |response|
  puts response.inspect
end
```

* Fetch hardsub streams for a video

```ruby
Viki::HardsubStream.fetch(video_id: '44699v') do |response|
  puts response.inspect
end

Viki::HardsubStream.fetch(video_id: '44699v', language: 'en') do |response|
  puts response.inspect
end
```

* Creates a master video

```ruby
Viki::MasterVideo.create(video_id: '44699v', url: "YOUTUBE_URL") do |response|
  puts response.inspect
end
```

* Get Master Video

```ruby
Viki::MasterVideo.fetch(video_id: '44699v') do |response|
  puts response.inspect
end
```

* Get Encoding Presets

```ruby
Viki::EncodingPreset.fetch do |response|
  puts response.inspect
end
```

* Encode Video

```ruby
Viki::EncodeJob.create(video_id: '44699v', profile: 'All') do |response|
  puts response.inspect
end
```

* Replace Streams

```ruby
Viki::ReplaceStream.update(old_video_id: '44699v', new_video_id: '45566v') do |response|
  puts response.inspect
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

* Fetch container summary

```ruby
Viki::ContainerSummary.fetch(id: '50c') do |response|
  puts response.value.inspect
end
```

* Fetch multiple ids from container

```ruby
Viki::Container.fetch(ids:'50c,504c') do |response|
  puts response.value.inspect
end
```

*  Fetch container base on type:

- Film container

```ruby
Viki::Film.fetch(id:'3466c') do |response|
  puts response.value.inspect
end
```

- Series container

```ruby
Viki::Series.fetch(id: '50c') do |response|
  puts response.value.inspect
end
```

- News container

```ruby
Viki::News.fetch(id: '3451c') do |response|
  puts response.value.inspect
end
```

- Artists container

```ruby
Viki::Artist.fetch(id: '4044c') do |response|
  puts response.value.inspect
end
```

- Artist - Fetching casts information

```ruby
Viki::Artist.casts_for('4044c') do |response|
  puts response.value.inspect
end
```


* Fetch recommended containers for a container

```ruby
Viki::Container.recommendations('3466c') do |response|
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

* List subscribers of a container

```ruby
Viki::Subscriber.fetch(resource_id: resource_id) do |response|
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
Viki::User.fetch(full_id: user_id) do |response|
  puts response.inspect
end
```

* Fetch user summary

```ruby
Viki::UserSummary.fetch(id: user_id) do |response|
  puts response.inspect
end
```

* Fetch user roles

```ruby
Viki::Role.fetch(user_id: user_id) do |response|
  puts response.inspect
end
```

* Fetch container roles (staff)

```ruby
Viki::Role.fetch(container_id: container_id) do |response|
  puts response.inspect
end
```

* Fetch user about page

```ruby
Viki::UserAbout.fetch(user_id: user_id) do |response|
  puts response.inspect
end
```

* Login

```ruby
Viki::Session.authenticate('tester@example.com', 'password', {}) do |response|
  puts response.inspect
end

Viki::Session.authenticate('username', 'password', {}) do |response|
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
# The gem will throw Viki::Core::ErrorResponse in case of invalid token,
# instead of return error object as in other methods
```

* Send reset password

```ruby
Viki::ResetPasswordToken.forgot_password!(user_email) do |response|
  puts response.inspect
end
```

* Update password from reset password token

```ruby
Viki::ResetPasswordToken.reset_password!(reset_password_token, password, password_confirmation) do |response|
  puts response.inspect
end
```

* Fetch user activities

```ruby
Viki::Activity.fetch(user_id: user_id) do | response |
  puts response.inspect
end
```

* Fetch activities

```ruby
Viki::Activity.fetch(type: 'all') do | response |
  puts response.inspect
end
```
See http://dev.viki.com/v4/activities/ for type params details

* Private message

```ruby
Viki::Thread.fetch(user_id: user_id, type: 'inbox') { |r| puts r.inspect }                 # Inbox
Viki::Thread.fetch(user_id: user_id, type: 'inbox', unread: true) { |r| puts r.inspect }   # Unread only
Viki::Thread.fetch(user_id: user_id, type: 'sent') { |r| puts r.inspect }                  # Sent
Viki::Thread.fetch(user_id: user_id, id: thread_id) { |r| puts r.inspect }                 # List messages
Viki::Thread.create({user_id: user_id}, to: to_id, content: 'hi') { |r| puts r.inspect }   # Create a thread
Viki::Thread.destroy(user_id: user_id, id: thread_id) { |r| puts r.inspect }               # Delete a thread
Viki::Thread.update(user_id: user_id, id: thread_id, unread: 'true') { |r| puts r.inspect }# Mark thread as Unread
Viki::Thread.update(user_id: user_id, id: thread_id, unread: 'false') { |r| puts r.inspect } # Mark thread as Read
Viki::Message.create({user_id: user_id, thread_id: thread_id}, content: 'hi') { |r| puts r.inspect } # Reply to a thread
Viki::Thread.unread_count(user_id) { |r| puts r.inspect }                                  # Unread count
```

* [Notification](#notification)

```ruby
Viki::Notification.create({container_id: container_id}, content: 'hi') { |r| puts r.inspect }  # Create an announcement
Viki::Notification.fetch(user_id: user_id) { |r| puts r.inspect }                         # Inbox
Viki::Notification.fetch(user_id: user_id, unread: true) { |r| puts r.inspect }           # Unread
Viki::Notification.fetch(user_id: user_id, id: notification_id) { |r| puts r.inspect }    # Get notification
Viki::Notification.update(user_id: user_id, id: notification_id, unread: true) { |r| puts r.inspect }  # Mark as Unread
Viki::Notification.update(user_id: user_id, id: notification_id, unread: false) { |r| puts r.inspect } # Mark as Read
Viki::Notification.destroy(user_id: user_id, id: notification_id) { |r| puts r.inspect }  # Delete a notification
Viki::Notification.unread_count(user_id) { |r| puts r.inspect }                           # Unread count
```

* Notification + Private message count

```ruby
Viki::Alert.unread_count(user_id) { |r| puts r.inspect }
```

* [Contribution](#contribution)

```ruby
Viki::Contribution.fetch(container_id: container_id) { |r| puts r.inspect } # container specific contributions
Viki::Contribution.fetch(user_id: user_id) { |r| puts r.inspect }           # user specific contributions
```

* Title

```ruby
Viki::Title.create({container_id: container_id}, {language_code: 'en', title: 'something'}) do |r|    # Create a container title
  puts r.inspect
end

Viki::Title.create({video_id: video_id}, {language_code: 'en', title: 'something'}) do |r|    # Create a video title
  puts r.inspect
end
```

* Description

```ruby
Viki::Description.create({container_id: container_id}, {language_code: 'en', description: 'something'}) |r|   # Create a container description
  puts r.inspect
end

Viki::Description.create({video_id: video_id}, {language_code: 'en', description: 'something'}) |r|   # Create a container description
  puts r.inspect
end
```

* Video Creation/Update

```ruby
Viki::video.create({container_id: container_id}, {type: 'episode', url: 'something'}) |r|   # Create a video
  puts r.inspect
end

Viki::video.update({container_id: container_id, video_id: video_id}, {type: 'episode', url: 'something', part: 2}) |r|   # Update a video
  puts r.inspect
end
```

* Timed Comments

```ruby
Viki::TimedComment.fetch(video_id: "44699v", language: "en") do |response|
  puts response.inspect  # SRT format
end
Viki::TimedComment.destroy(video_id: "44699v", timed_comment_id: "42tc") do |response|
  puts response.inspect  # JSON format
end
```

* Ads

```ruby
Viki::Ad.fetch(video_id: '44699v') do |response|
  puts response.inspect
end
```

* Translations

```ruby
Viki::Translation.random(origin_language: 'en', target_language: 'es') do |response| # get random translation
  puts r.inspect
end

Viki::Translation.rating(origin_subtitle_id: '1s', target_subtitle_id: '2s', like: true) do |response| # like a translation
  puts r.inspect
end

Viki::Translation.rating(origin_subtitle_id: '1s', target_subtitle_id: '2s', like: false, suggested_content: 'something') do |response| # dislike a translation with suggestion
  puts r.inspect
end

Viki::Translation.report(subtitle_id: '1s') do |response| # report a subtitle
  puts r.inspect
end
```

* Captions

```ruby
Viki::Caption.random(origin_language: 'en', target_language: 'es') do |response| # get random caption
  puts r.inspect
end

Viki::Caption.create(origin_subtitle_id: '1s', language: 'ko', content: 'new caption') do |response| # create a caption
  puts r.inspect
end

Testing Tool
------------

#### Async Stub
Stub value will not be returned immediately when method get called, instead it will be recored and will be returned later when `Viki.run` get called.

###### Setup
Add this line to spec_helper.rb
```ruby
require 'viki_stub'
```
###### Use
Use `async_stub` in replace of `stub`. Example:
```ruby
Viki::User.async_stub(....).with(....).and_yield(...)
```
###### Limitation
Only works with built-in RSpec mock framwork

Changelog
---------
* 1.4.8
  * Log api response time in request

* 1.4.6
  * Leaaderboard

* 1.4.5
  * Caption

* 1.4.4
  * Subtitle reporting

* 1.4.3
  * Bugfix - parsed cache content not initialized get_content of body

* 1.4.2
  * Ability to fetch list of countries by resource type

