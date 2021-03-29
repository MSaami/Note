module FolderManager
  class Create < ApplicationService
    def initialize(name, user)
      @user = user
      @name = name
    end

    def execute
      folder = @user.folders.new({
        name: @name
      })
      folder.save!
      folder
    end
  end
end
