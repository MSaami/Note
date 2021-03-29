module Api::V1
    class SessionsController < BaseController
      skip_before_action :authenticate_user

      def create
        auth = Authentication::UserAuthentication.new(permit_params)
        raise AuthenticationError unless auth.authenticated?
        token = Authentication::TokenCreator.call(auth.user.id)
        render json: { token: token }, status: :created
      end

      private
      def permit_params
        params.require(:login).permit(:email, :password)
      end
    end
  end
