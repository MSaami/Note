require 'rails_helper'

RSpec.describe Authentication::UserAuthentication do
  let(:user) { FactoryBot.create(:user, email: 'dummy@gmail.com', password: '123456')}

  describe '#authenticated?' do
    it "returns true with correct user password" do
      user_service = described_class.new({email: user.email, password: user.password})
      expect(user_service.authenticated?).to be true
    end

    it "returns false if password is incorrect" do
      user_service = described_class.new({email: user.email, password: 'Incorrect'})
      expect(user_service.authenticated?).to be false
    end

    it "returns false if user or password is nil" do
      user_service = described_class.new({})
      expect(user_service.authenticated?).to be false
    end
  end

  describe '#user' do
    it "get authenticated user if credentials is correct" do
      user_service = described_class.new({email: user.email, password: user.password})
      expect(user_service.user).to be_a User
      expect(user_service.user.email).to eq(user.email)
    end

    it "returns false if credentials is incorrect" do
      user_service = described_class.new({email: user.email, password: 'Incorrect'})
      expect(user_service.user).to be false 
    end
  end
end
