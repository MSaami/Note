require 'rails_helper'

RSpec.describe NoteManager::Index do
  let!(:user) { FactoryBot.create(:user) }
  let!(:notes) { FactoryBot.create_list(:note, 25, user: user) }
  let!(:other_notes) { FactoryBot.create_list(:note, 5) }

  describe ".call" do
    it "return user notes" do
      expect(described_class.call(user).count).to eq(25)
    end
  end
end
