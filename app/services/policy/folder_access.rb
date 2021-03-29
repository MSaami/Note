module Policy
  class FolderAccess < ApplicationService
    def initialize(user, folder_id)
      @user = user
      @folder_id = folder_id
    end

    def execute
      raise AuthorizationError unless @folder_id.nil? or Folder.where(id: @folder_id, user_id: @user.id).exists?
    end
  end
end
