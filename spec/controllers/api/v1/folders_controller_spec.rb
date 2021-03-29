require 'rails_helper'

RSpec.describe Api::V1::FoldersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let!(:token) { Authentication::TokenCreator.call(user.id) }


  context 'with token' do
    before do
      controller.request.headers['Authorization'] = "Bearer #{token}"
    end

    describe '#create' do
      it "can create folder for user and returns created response" do
        post :create, params: {folder: {name: 'Tech'}}
        expect(response).to have_http_status(:created)
        expect(user.folders.count).to eq(1)
        expect(user.folders.first.name).to  eq('Tech')
      end

      it "returns unprocessable_entity when name is nil" do
        post :create, params: {folder: {name: nil}}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    describe '#index' do
      let!(:folders) { FactoryBot.create_list(:folder, 4, user: user)}
      let!(:notes) { FactoryBot.create_list(:note, 10, folder: folders.first, user: user)}


      it "can get all of her folders" do
        get :index
        body = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(body['data'].count).to eq(4)
      end

      it "can get all of her folders with notes" do
        get :index
        body = JSON.parse(response.body)
        expect(body['data'].first['attributes']['notes'].count).to eq(10)
      end
    end
  end
end
