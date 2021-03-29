require 'rails_helper'

RSpec.describe NoteManager::Create do
  let!(:user) { FactoryBot.create(:user) }

  describe ".call" do
    it "can create notes for user" do
      described_class.call({body: 'Dummy'}, user)
      expect(user.notes.count).to eq(1)
    end

    it "can create notes with folder" do
      folder = FactoryBot.create :folder
      described_class.call({body: 'With Folder', folder_id: folder.id}, user)
      expect(Note.find_by_body('With Folder').folder_id).to eq(folder.id)
    end

    it "can create notes in default folder if folder is not specified" do
      described_class.call({body: 'With Default Folder'}, user)
      expect(Note.find_by_body('With Default Folder').folder.name).to eq('default')
    end

    it "throw exception if given body is nil" do
      expect { described_class.call({body: nil}, user) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "throws exception if folder is not exist" do
      expect { described_class.call({body: "Dummy", folder_id: 4}, user) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

end
