require 'rails_helper'

RSpec.describe NoteManager::Destroy do
  let!(:note) { FactoryBot.create(:note) }

  describe ".call" do
    it "destroy note" do
      described_class.call(note.id)
      expect(Note.find_by_id(note.id)).to be nil
    end
  end
end
