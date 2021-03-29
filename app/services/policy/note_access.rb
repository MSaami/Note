module Policy
  class NoteAccess < ApplicationService
    def initialize(user, note_id)
      @user = user
      @note_id = note_id
    end

    def execute
      raise AuthorizationError unless Note.where(id: @note_id, user_id: @user.id).exists?
    end
  end
end
