require "spec_helper"

describe Viki::Session, api: true do
  describe '.authenticate' do
    it 'authenticates the user' do
      stub_api 'sessions.json', '{"token": "123456"}', method: :post, api_version: 'v5'
      described_class.authenticate('user', 'pass') do |response|
        response.error.should be_nil
      end
    end

    it 'raises error when the authentication fails' do
      stub_api 'sessions.json', '{"vcode": "404"}',
               method: :post, response_code: 404, api_version: 'v5'
      described_class.authenticate('user', 'pass') do |response|
        response.error.should_not be_nil
      end
    end

    it 'authenticate with extra params' do
      params = {app: Viki.app_id}
      stub_request("post", "http://api.dev.viki.io/v5/sessions.json").
          with(query: hash_including(:sig, :t, params),
               headers: {'Content-Type' => 'application/json', 'User-Agent' => 'viki'},
               body: hash_including("sign" => "me_in","username"=> "user", "password"=> "pass")).
          to_return(body: '{"token" : "123456"}', status: 200)

      described_class.authenticate('user', 'pass', {sign: 'me_in'}) do |response|
        response.error.should be_nil
      end
    end
  end

  describe ".auth_facebook" do
    it 'authenticate the use with facebook token' do
      params = {app: Viki.app_id}
      stub_request("post", "http://api.dev.viki.io/v5/sessions.json").
          with(query: hash_including(:sig, :t, params),
               headers: {'Content-Type' => 'application/json', 'User-Agent' => 'viki'},
               body: hash_including("facebook_token" => 'token')).
          to_return(body: '{"token" : "123456"}', status: 200)

      described_class.auth_facebook('token') do |response|
        response.error.should be_nil
      end
    end

    it 'authenticate the use with facebook token and params' do
      params = {app: Viki.app_id}
      stub_request("post", "http://api.dev.viki.io/v5/sessions.json").
          with(query: hash_including(:sig, :t, params),
               headers: {'Content-Type' => 'application/json', 'User-Agent' => 'viki'},
               body: hash_including("facebook_token" => 'token', 'sign' => 'me_in')).
          to_return(body: '{"token" : "123456"}', status: 200)

      described_class.auth_facebook('token', {'sign'=>"me_in"}) do |response|
        response.error.should be_nil
      end
    end
  end

  describe ".fetch" do
    it 'calls v5 endpoint' do
      params = {app: Viki.app_id}
      stub_request("get", "http://api.dev.viki.io/v5/sessions/token.json")
        .with(query: hash_including(:sig, :t, params), headers: {'Content-Type'=>'application/json', 'User-Agent'=>'viki'})
        .to_return(:status => 200, :body => "", :headers => {})

      described_class.fetch(token: 'token') do |res|
        res.error.should be_nil
      end
    end
  end

  describe ".update" do
    it 'calls v4 endpoint' do
      params = {app: Viki.app_id}
      stub_request("put", "http://api.dev.viki.io/v4/sessions/token.json")
        .with(query: hash_including(:sig, :t, params), headers: {'Content-Type'=>'application/json', 'User-Agent'=>'viki'})
        .to_return(:status => 200, :body => "", :headers => {})

      described_class.update(token: 'token') do |res|
        res.error.should be_nil
      end
    end
  end

  describe ".fetch_sync" do
    it 'calls v5 endpoint' do
      params = {app: Viki.app_id}
      stub_request("get", "http://api.dev.viki.io/v5/sessions/token.json")
        .with(query: hash_including(:sig, :t, params), headers: {'Content-Type'=>'application/json', 'User-Agent'=>'viki'})
        .to_return(:status => 200, :body => "", :headers => {})

      res = described_class.fetch_sync(token: 'token')
      res.error.should be_nil
    end
  end

  describe ".update_sync" do
    it 'calls v4 endpoint' do
      params = {app: Viki.app_id}
      stub_request("put", "http://api.dev.viki.io/v4/sessions/token.json")
        .with(query: hash_including(:sig, :t, params), headers: {'Content-Type'=>'application/json', 'User-Agent'=>'viki'})
        .to_return(:status => 200, :body => "", :headers => {})

      res = described_class.update_sync(token: 'token')
      res.error.should be_nil
    end
  end
end
