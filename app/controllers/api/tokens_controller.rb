module Api
  class TokensController < ApiController
    skip_before_action :authenticate!, only: %i[create refresh]

    def create
      user = User.not_deleted.find_by(email: params.require(:email))

      raise AuthenticateError unless user
      raise AuthenticateError unless user.password == params.require(:password)

      render json: JwtGenerator.jwt_pair(user)
    end

    def refresh
      payload = JWT.decode(params.require(:refresh_token), jwt_key).first
      user = User.not_deleted.find payload['user_id']

      raise AuthenticateError unless user

      render json: JwtGenerator.jwt_pair(user)
    end
  end
end
