require 'rails_helper'

describe Api::RegistrationsController do
  describe 'POST #signup' do
    it 'creates user with email, name, password' do
      expect {
        post :signup, params: attributes_for(:user)
      }.to change(User, :count).by(1)
    end

    it 'not creates user without email' do
      post :signup, params: { name: Faker::Name.first_name, password: '12345678' }

      expect(response.status).to eq 422
    end

    it 'not creates user without name' do
      post :signup, params: { password: '12345678', email: Faker::Internet.email }

      expect(response.status).to eq 422
    end

    it 'not creates user without password' do
      post :signup, params: { name: Faker::Name.first_name, email: Faker::Internet.email }

      expect(response.status).to eq 422
    end

    it 'return tokens' do
      post :signup, params: attributes_for(:user)

      expect(response.body['access_token'].present?).to be true
    end
  end
end
