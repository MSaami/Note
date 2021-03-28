module Api
  module V1
    class BaseController < ApplicationController
      class AuthenticationError < StandardError; end
      rescue_from ActionController::ParameterMissing, with: :parameter_missing
      rescue_from AuthenticationError, with: :unauthorized

      protected
      def authenticate_user
        authenticate_or_request_with_http_token do |token, options|
        end
      end

      def parameter_missing(e)
        render json: { error: e.message }, status: :unprocessable_entity
      end

      def unauthorized
        render json: { error: 'Your credentials are not valid' }, status: :unauthorized
      end
    end
  end
end
