module DecodeRefresh
  class << self
    def payload(request, jwt_key)
      parsed_cookies = CookieParser.parse request.headers['Cookie']
      refresh_token = parsed_cookies['refresh_token']

      return {} if refresh_token == 'not_exist'

      JWT.decode(refresh_token, jwt_key).first
    end
  end
end
