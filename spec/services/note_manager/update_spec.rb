require 'rails_helper'

RSpec.describe NoteManager::Update do
  let!(:note) { FactoryBot.create(:note, body: 'Dummy') }

  describe ".call" do
    it "can update body and folder" do
      user = FactoryBot.create(:user)
      folder = FactoryBot.create(:folder, user: user)
      described_class.call(note.id, {body: "after update", folder_id: folder.id})
      expect(note.reload.body).to eq('after update')
      expect(note.reload.folder_id).to eq(folder.id)
    end

    it "throws exception if folder id is invalid" do
      expect { described_class.call(note.id, { folder_id: 222222} )}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "throw exception if body is nil" do
      expect { described_class.call(note.id, { body: nil} )}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
