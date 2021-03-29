module FolderManager
  class Index < ApplicationService
    def initialize(user)
      @user = user
    end

    def execute
      @user.folders.includes(:notes)
    end
  end
end
