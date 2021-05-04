module DecodeRefresh
  class << self
    def payload(request, jwt_key)
      parsed_cookies = CookieParser.parse request.headers['Cookie']
      refresh_token = parsed_cookies['refresh_token']

      return {} unless refresh_token
      return {} if refresh_token == 'not_exist'

      begin
        JWT.decode(refresh_token, jwt_key).first
      rescue JWT::ExpiredSignature
        raise MobileApi::TokenError
      end
    end
  end
end
