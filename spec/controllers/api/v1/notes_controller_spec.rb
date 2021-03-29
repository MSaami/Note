require 'rails_helper'

RSpec.describe Api::V1::NotesController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:token) { Authentication::TokenCreator.call(user.id)}

  describe 'valid token' do
    before do
      controller.request.headers['Authorization'] = "Bearer #{token}"
    end
    describe '#create' do
      it "returns created response when note has been created" do
        post :create, params:{note: {body: 'Dummy'}}
        expect(response).to have_http_status(:created)
      end

      it "returns unprocessable_entity if body is nil" do
        post :create, params:{note: {body: nil}}
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "create note when data is valid" do
        post :create, params:{note: {body: 'Dummy'}}
        expect(user.notes.count).to eq(1)
      end

      describe '#index' do
        it "returns notes from user if token is valid" do
          FactoryBot.create_list(:note, 25, user: user)
          get :index
          body = JSON.parse(response.body)
          expect(body['data'].count).to eq(25)
        end
      end

      describe '#update' do
        let(:note) { FactoryBot.create(:note, user: user) }
        let(:folder) { FactoryBot.create(:folder, user: user)}

        it "user can update notes" do
          put :update, params: {id: note.id, note: {body: 'After Update', folder_id: folder.id}}
          expect(response).to have_http_status(:no_content)
          expect(note.reload.body).to eq('After Update')
          expect(note.reload.folder_id).to eq(folder.id)
        end

        it "user get unprocessable_entity status if body is nil" do
          put :update, params: {id: note.id, note: {body: nil, folder_id: folder.id}}
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it "user get unprocessable_entity status if folder is invalid" do
          put :update, params: {id: note.id, note: {body: 'Update With invalid folder', folder_id: 2334344}}
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      describe '#destroy' do
        let(:note) { FactoryBot.create(:note, user: user)}
        it "user can destroy note" do
          delete :destroy, params: {id: note.id}
          expect(response).to have_http_status(:no_content)
        end
      end
    end
  end

  describe 'invalid token' do
    describe "#create" do
      it "returns unauthorized status if token is invalid" do
        post :create, params:{note: {body: nil}}
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end

