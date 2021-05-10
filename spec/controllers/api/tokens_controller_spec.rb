require 'rails_helper'

describe Api::TokensController do
  describe 'POST #create' do
    it 'return authenticate error with uncorrect email' do
      post :create, params: { email: 'email', password: '123' }

      expect(response.status).to eq 401
    end

    it 'return authenticate error with uncorrect password' do
      user = create(:user)
      post :create, params: { email: user.email, password: '123' }

      expect(response.status).to eq 401
    end

    it 'return new access token if correct email and password' do
      user = create(:user, password: '12345678')
      post :create, params: { email: user.email, password: '12345678' }

      expect(response.body['access_token'].present?).to be true
    end
  end

  describe 'POST #refresh' do
    it 'return authenticate error without user' do
      refresh_token = JwtGenerator.make_token({ user_id: 'ola' })
      request.cookies[:refresh_token] = refresh_token

      post :refresh

      expect(response.status).to eq 401
    end

    it 'return authenticate error without payload' do
      request.cookies[:refresh_token] = JwtGenerator.make_token

      post :refresh

      expect(response.status).to eq 401
    end

    it 'return new access token' do
      user = create(:user)
      refresh_token = JwtGenerator.refresh_token(user)
      request.cookies[:refresh_token] = refresh_token

      post :refresh

      expect(response.body['access_token'].present?).to be true
    end
  end

  describe 'POST #signout' do
    it 'set refresh token cookie to not_exist' do
      post :signout

      expect(response.cookies['refresh_token']).to eq 'not_exist'
    end
  end
end
