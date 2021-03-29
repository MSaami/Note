module FolderManager
  class GetDefault < ApplicationService
    def initialize(user)
      @user = user
    end

    def execute
      @user.default_folder || FolderManager::Create.call('default', @user)
    end
  end
end
