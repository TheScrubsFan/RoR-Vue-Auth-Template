class ApplicationController < ActionController::Base
  def decoded_token
    return @token_payload if @token_payload

    match_data = /Bearer (.+)/.match(request.headers['Authorization'])

    return {} unless match_data

    token = match_data[1]

    return {} unless token

    payload = JWT.decode(token, jwt_key)[0]
    @token_payload = payload.with_indifferent_access
  rescue JWT::DecodeError
    {}
  end
end
