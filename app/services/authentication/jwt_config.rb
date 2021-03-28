module Authentication
  module JwtConfig
    def get_secret_key
      Rails.application.secrets.secret_key_base
    end

    def get_algorithm
      Rails.configuration.jwt[:algorithm]
    end
  end
end
