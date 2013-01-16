Viki API gem
============

This gem gives tools to access the Viki.com API.

Installation
------------

Add the gem in your `Gemfile`

```
gem "viki-api-gem",
    git: "https://github.com/viki-org/viki-api-gem.git",
    require: 'viki',
```

Now you need to configure it. In Rails you can create a `viki.rb` in your initializers folder with
the following content:

```
Viki.configure do |c|
  c.salt = "your salt"
  c.app_id = "your app_id"
end
```

Development
-----------

Make sure you have bundler >= 1.2.

To develop with a local copy of the viki-api-gem, run the following command:

```
bundle config local.viki-api-gem ~/workspace/viki_api_gem/
```

This will use your local copy of the gem instead of the remote one.
