require 'sinatra'
require 'rack/test'

ENV['SSO_HOST'] = 'http://some.host.com'
ENV['SSO_AUTHORIZE_PATH'] = '/sps/oauth20sp/oauth20/authorize'
ENV['SSO_TOKEN_PATH'] = '/sps/oauth20sp/oauth20/token'

require File.join(File.dirname(__FILE__), '..', 'app')


# setup test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

def app
  App
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
