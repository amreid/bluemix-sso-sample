require 'sinatra/base'
require 'oauth2'
require 'slim'

class App < Sinatra::Base

  # Single Sign On service configuration
  SSO_HOST = ENV['SSO_HOST']
  SSO_TOKEN_PATH = ENV['SSO_TOKEN_PATH']
  SSO_AUTHORIZE_PATH = ENV['SSO_AUTHORIZE_PATH']
  PROFILE_PATH = ENV['PROFILE_PATH']

  SSO_LOGOUT_PATH = ENV['SSO_LOGOUT_PATH']

  # Setting from Single Sign On Client Configuration page
  CLIENT_ID = ENV['CLIENT_ID']
  CLIENT_SECRET = ENV['CLIENT_SECRET']

  # where SSO calls us back after authenticated
  AUTH_CALLBACK_PATH = '/auth/oauth2/callback'

  configure do
    set :client, OAuth2::Client.new(CLIENT_ID, CLIENT_SECRET, site: SSO_HOST, authorize_url: SSO_AUTHORIZE_PATH, token_url: SSO_TOKEN_PATH)
    set :root, File.dirname(__FILE__)
  end

  get '/' do
    # render the index.slim page
    slim :index
  end

  get '/profile' do
    # this will redirect to the sso authorize service requesting access to the profile service
    redirect App.client.auth_code.authorize_url(redirect_uri: redirect_uri(request), scope: 'profile')
  end

  get AUTH_CALLBACK_PATH do

    # first exchange the code for a bearer token. this returns a instance of a OAuth2::AccessToken
    token = App.client.auth_code.get_token(params[:code], redirect_uri: redirect_uri(request))

    # next use the token to make a request to the profile service
    properties = JSON.parse(token.post("#{SSO_HOST}/#{PROFILE_PATH}").response.body)

    # alternatively you can fetch the actual bearer token from the AccessToken (possibly store it in session for later use)
    # and use it with a REST client of your choice like this:
    # RestClient.post 'https://idaas.ng.bluemix.net/idaas/resources/profile.jsp', { 'access_token' => token.token }

    # now render the profile.slim page with the user profile properties
    slim :profile, locals: { properties: properties }

  end

  def redirect_uri(request)
    "#{request.scheme}://#{request.host}#{AUTH_CALLBACK_PATH}"
  end

end
