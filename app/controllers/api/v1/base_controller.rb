module Api::V1
  class BaseController < ApplicationController
    class AuthenticationError < StandardError; end
    include ActionController::HttpAuthentication::Token::ControllerMethods
    rescue_from ActionController::ParameterMissing, with: :parameter_missing
    rescue_from AuthenticationError, with: :unauthorized
    rescue_from JWT::VerificationError, with: :unauthorized
    rescue_from ActiveRecord::RecordNotFound, with: :unauthorized
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    before_action :authenticate_user

    protected
    def authenticate_user
      authenticate_or_request_with_http_token do |token, options|
        user_id = Authentication::TokenDecoder.call(token)
        @current_user = User.find(user_id)
      end
    end

    def parameter_missing(e)
      render json: { error: e.message }, status: :unprocessable_entity
    end

    def unauthorized
      render json: { error: 'Your credentials are invalid' }, status: :unauthorized
    end

    def record_invalid(e)
      render json: { errors: e.record.errors }, status: :unprocessable_entity
    end
  end
end
