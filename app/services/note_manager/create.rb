module NoteManager
  class Create < ApplicationService
    def initialize(params, user)
      @params = params
      @user = user
    end

    def execute
      folder_id = @params[:folder_id] || FolderManager::GetDefault.call(@user).id
      note = @user.notes.new({
        body: @params[:body],
        folder_id: folder_id,
        file: @params[:file]
      })
      note.save!
    end
  end
end
