module JwtGenerator
  class << self
    def jwt_pair(user)
      {
        access_token: access_token(user),
        refresh_token: refresh_token(user)
      }
    end

    def access_token(user)
      payload = {
        scope: 'api',
        user_id: user.id,
        nbf: Time.now.to_i,
        exp: Time.now.to_i + ENV.fetch('JWT_TOKEN_LIFETIME').to_i
      }

      make_token payload
    end

    def refresh_token(user)
      payload = {
        scope: 'api',
        user_id: user.id,
        nbf: Time.now.to_i,
        exp: Time.now.to_i + ENV.fetch('JWT_REFRESH_TOKEN_LIFETIME').to_i
      }

      make_token payload
    end

    def make_token(payload = {}, jwt_key = ENV.fetch('SECRET_KEY_BASE'))
      JWT.encode payload, jwt_key
    end
  end
end
