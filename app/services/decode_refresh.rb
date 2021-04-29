module DecodeRefresh
  class << self
    def user_id(request, jwt_key)
      parsed_cookies = CookieParser.parse request.headers['Cookie']
      refresh_token = parsed_cookies['refresh_token']

      return nil if refresh_token == 'not_exist'

      payload = JWT.decode(refresh_token, jwt_key).first

      payload['user_id']
    end
  end
end
