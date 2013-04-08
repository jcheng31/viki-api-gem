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
  c.logger = Logger.new(STDOUT) # The logger to use from the gem
  c.timeout_seconds = 30 # The timeout for the requests.
end
```

Configuration
-------------

* `c.salt` Must contain you salt. Default to `ENV["VIKI_API_SALT"]`. Either in config or using `ENV`, it is **required**.

* `c.app_id` Must contain you application id. Default to `ENV["VIKI_API_APP_ID"]`. Either in config or using `ENV`, it is **required**.

* `c.user_ip` Lambda block returning the IP address of the user. It is put in the header of the requests to the API as `X-FORWARDED-FOR`. **Required**

* `c.user_token` Lambda block returning the session token of the user. **Required**

* `c.logger` Instance of `Logger` you want the gem to use. Default to `Logger.new(STDOUT)`. **Optional**

* `c.timeout_seconds` Amount of seconds for the requests. If a request takes longer, it will return an error

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
Viki::Stream.fetch(video_id: "44699v", language: "en") do |response|
  puts response.inspect
end
```

* Fetch streams for a video

```ruby
Viki::Stream.fetch(video_id: '44699v') do |response|
  puts response.inspect
end
```

* Creates a master video

```ruby
Viki::MasterVideo.create(video_id: '44699v', url: "YOUTUBE_URL") do |response|
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
Viki::Session.authenticate('tester@example.com', 'password') do |response|
  puts response.inspect
end

Viki::Session.authenticate('username', 'password') do |response|
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
Viki::Message.create({user_id: user_id, id: thread_id}, content: 'hi') { |r| puts r.inspect }# Reply to a thread
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
```

* Description

```ruby
Viki::Description.create({container_id: container_id}, {language_code: 'en', description: 'something'}) |r|   # Create a container description
  puts r.inspect
end
```

* Video Creation

```ruby
Viki::video.create({container_id: container_id}, {type: 'episode', url: 'something'}) |r|   # Create a video
  puts r.inspect
end
```

Changelog
---------
* 0.0.62
  * Support video creation via containers/:container_id/videos.json

* 0.0.61
  * Support user contributions

* 0.0.60
  * Support for activities endpoint

* 0.0.57
  * Added ContainerSummary and UserSummary

* 0.0.53
  * Correct title and description endpoint

* 0.0.52
  * Support for container title and description create
