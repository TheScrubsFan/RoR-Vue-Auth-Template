module Api
  class RegistrationsController < ApiController
    skip_before_action :authenticate!, only: %i[signup]

    def signup
      user = User.create params_for_create

      jwt_cookie user

      render json: {
        access_token: JwtGenerator.access_token(user)
      }
    end

    private

    def params_for_create
      params.permit(:name, :email, :password)
    end
  end
end
