require 'rails_helper'

RSpec.describe FolderManager::GetDefault do
  let!(:user) { FactoryBot.create(:user) }

  describe '.call' do
    let!(:user) { FactoryBot.create(:user) }

    it "makes default folder if user has not that" do
      expect(described_class.call(user).name).to eq('default')
    end

    it "get exists folder if user has default one" do
      folder = FactoryBot.create(:folder, user: user, name: 'default')
      expect(described_class.call(user).id).to eq(folder.id)
    end
  end
end
