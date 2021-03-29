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

      it "creates note with file" do
        file = fixture_file_upload('video.mp4')
        post :create, params: {note: {body: 'With File', file: file}}
        expect(response).to have_http_status(:created)
        expect(Note.find_by_body('With File').file.attached?).to be true
      end

      describe '#index' do
        let!(:notes) {FactoryBot.create_list(:note, 5, user: user)}
        it "returns notes from user if token is valid" do
          get :index
          body = JSON.parse(response.body)
          expect(body['data'].count).to eq(notes.count)
        end

        it "returns notes from user with files" do
          get :index
          body = JSON.parse(response.body)
          expect(body['data'].first['attributes']['file_url']).not_to be_empty
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

        it "user can update the file" do
          last_file_url = note.file_url
          image = fixture_file_upload('image.png')
          put :update, params: {id: note.id, note: {file: image}}
          expect(note.reload.file_url).not_to eq(last_file_url)
        end

        it "return 404 status if note id is invalid" do
          put :update, params: {id: 1111111, note: {body: 'After'}}
          expect(response).to have_http_status(:not_found)
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

