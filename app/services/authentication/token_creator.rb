module Authentication
  class TokenCreator < ApplicationService
    include JwtConfig

    def initialize(user_id)
      @user_id = user_id
    end

    def execute
      JWT.encode get_payload, get_secret_key, get_algorithm
    end

    private

    def get_payload
      {
        user_id: @user_id,
        exp: Time.now.to_i + Rails.configuration.jwt[:expire_time]
      }
    end

  end
end
