module Api::V1
    class SessionsController < BaseController
      skip_before_action :authenticate_user

      def create
        user = User.find_by_email(permit_params[:email])
        &.authenticate(permit_params[:password])
        raise AuthenticationError unless user
        token = Authentication::TokenCreator.call(user.id)
        render json: { token: token }, status: :created
      end

      private
      def permit_params
        params.require(:login).permit(:email, :password)
      end
    end
  end
