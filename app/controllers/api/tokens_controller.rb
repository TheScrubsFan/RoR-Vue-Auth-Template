module Api
  class TokensController < ApiController
    skip_before_action :authenticate!, only: %i[create refresh]

    def create
      user = User.not_deleted.find_by(email: params.require(:email))

      raise AuthenticateError unless user
      raise AuthenticateError unless user.password == params.require(:password)

      response.set_cookie :refresh_token, { value: JwtGenerator.refresh_token(user), httponly: true }

      render json: {
        access_token: JwtGenerator.access_token(user)
      }
    end

    def refresh
      parsed_cookies = CookieParser.parse request.headers['Cookie']
      refresh_token = parsed_cookies['refresh_token']
      payload = JWT.decode(refresh_token, jwt_key).first
      user = User.not_deleted.find payload['user_id']

      raise AuthenticateError unless user.id == payload['user_id']
      raise AuthenticateError unless payload['scope'] == 'api'

      response.set_cookie :refresh_token, { value: JwtGenerator.refresh_token(user), httponly: true }

      render json: {
        access_token: JwtGenerator.access_token(user)
      }
    end
  end
end
