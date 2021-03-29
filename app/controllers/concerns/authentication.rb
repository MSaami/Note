module Authentication
  extend ActiveSupport::Concern
  include ActionController::HttpAuthentication::Token::ControllerMethods

  included do
    before_action :authenticate_user
  end

  def authenticate_user
    authenticate_or_request_with_http_token do |token, options|
      user_id = Authentication::TokenDecoder.call(token)
      @current_user = User.find(user_id)
    end
  end
end
