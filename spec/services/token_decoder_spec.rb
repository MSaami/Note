require 'rails_helper'

RSpec.describe Authentication::TokenDecoder do
  describe '.call' do
    it "returns user_id if token is valid" do
      token = Authentication::TokenCreator.call(1)
      user_id = described_class.call(token)
      expect(user_id).to eq(1)
    end

    it "throws exception if token is invalid" do
      fake_token = 'dummydummy'
      expect { described_class.call(fake_token) }.to raise_error(JWT::VerificationError)
    end
  end
end
