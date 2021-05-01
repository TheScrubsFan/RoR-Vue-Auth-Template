module Api
  class TokensController < ApiController
    skip_before_action :authenticate!, only: %i[create refresh signout]

    def create
      user = User.not_deleted.find_by(email: params.require(:email))

      raise AuthenticateError unless user
      raise AuthenticateError unless user.password == params.require(:password)

      jwt_cookie user

      render json: {
        access_token: JwtGenerator.access_token(user)
      }
    end

    def refresh
      payload = DecodeRefresh.payload request, jwt_key
      user = User.not_deleted.find_by id: payload['user_id']

      raise AuthenticateError unless user
      raise AuthenticateError unless payload['scope'] == 'api'

      jwt_cookie user

      render json: {
        access_token: JwtGenerator.access_token(user)
      }
    end

    def signout
      response.set_cookie :refresh_token, {
        value: 'not_exist',
        httponly: true,
        path: '/'
      }

      render json: 'ok'
    end

  end
end
