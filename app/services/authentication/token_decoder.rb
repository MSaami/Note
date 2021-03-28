module Authentication
  class TokenDecoder < ApplicationService
    include JwtConfig
    def initialize(token)
      @token = token
    end

    def execute
      decoded_token = JWT.decode @token, get_secret_key, true, { algorithm: get_algorithm }
      decoded_token[0]['user_id']
    rescue StandardError => e
     raise JWT::VerificationError
    end
  end
end
