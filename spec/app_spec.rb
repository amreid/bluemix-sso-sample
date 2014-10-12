require 'spec_helper'
require 'json'
require 'pry'

describe 'SSO App' do

  let(:request) { double('request', scheme: 'http', host: 'acme.com')}

  it 'has default route' do
    get '/'
    expect(last_response).to be_ok
  end

  it 'redirect_uri method does not include port' do
    expect(app.new!.redirect_uri(request)).to eq 'http://acme.com/auth/oauth2/callback'
  end

  it 'profile causes redirect' do
    get '/profile'
    expect(last_response.redirect?).to eq true
  end

  it 'redirects to authorize' do
    get '/profile'
    follow_redirect!
    expect(last_request.path).to eq '/sps/oauth20sp/oauth20/authorize'
  end

  context 'configures auth client' do

    it 'to be a oauth2 client' do
      expect(app.client).to be_a OAuth2::Client
    end

    it 'with site host' do
      expect(app.client.site).to eq 'http://some.host.com'
    end

    it 'with authorize path' do
      expect(app.client.authorize_url).to eq 'http://some.host.com/sps/oauth20sp/oauth20/authorize'
    end

    it 'with token path' do
      expect(app.client.token_url).to eq 'http://some.host.com/sps/oauth20sp/oauth20/token'
    end

  end
end
