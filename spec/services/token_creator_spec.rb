require 'rails_helper'

RSpec.describe Authentication::TokenCreator do
  describe '.call' do
    it "returns valid jwt token with valid payload" do
      secret = Rails.application.secrets.secret_key_base
      token = described_class.call(1)
      decoded_token = JWT.decode token, secret, true, { algorithm: Rails.configuration.jwt[:algorithm] }
      expect(decoded_token[0]["user_id"]).to eq(1)
    end
  end
end
