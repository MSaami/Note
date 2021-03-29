require 'rails_helper'

RSpec.describe FolderManager::Create do
  let!(:user) { FactoryBot.create(:user)}
  describe ".call" do
    it "can create folder" do
      described_class.call('Dummy', user)
      expect(user.folders.count).to eq(1)
    end

    it "throws exception if name is invalid" do
      expect { described_class.call(nil, user)}.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
