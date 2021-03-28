require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  describe '#create' do
    context 'login with api' do
      let!(:user) { FactoryBot::create(:user, email: 'dummy@gmail.com', password: '123456') }

      it "get created response when the user and password are correct" do
        post :create, params: {login: {email: 'dummy@gmail.com', password: '123456'} }
        expect(response).to have_http_status(:created)
      end

      it "get token when the user and password are correct" do
        post :create, params: {login: {email: 'dummy@gmail.com', password: '123456'} }
        body = JSON.parse(response.body)
        expect(body).to have_key('token')
      end

      it "get unauthorized status when user and password is incorrect" do
        post :create, params: {login: {email: 'dummydummy@gmail.com', password: '123456'} }
        expect(response).to have_http_status(:unauthorized)
      end

      it "get unprocessable_entity status if login key havent sent" do
        post :create, params: {email: 'dummydummy@gmail.com', password: '123456' }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end

