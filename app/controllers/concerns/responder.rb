module Responder
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::ParameterMissing, with: :parameter_missing
    rescue_from JWT::VerificationError, with: :unauthorized
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from AuthorizationError, with: :forbidden
    rescue_from AuthenticationError, with: :unauthorized
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

  def record_not_found
    render json: { error: 'Record not found' }, status: :not_found
  end

  def forbidden
    render json: { error: 'Forbidden'}, status: :forbidden
  end
end
