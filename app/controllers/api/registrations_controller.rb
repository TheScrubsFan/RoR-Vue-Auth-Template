module Api
  class RegistrationsController < ApiController
    skip_before_action :authenticate!, only: %i[signup]

    def signup
      user = User.create params_for_create

      render json: JwtGenerator.jwt_pair(user)
    end

    private

    def params_for_create
      params.permit(:name, :email, :password)
    end
  end
end
