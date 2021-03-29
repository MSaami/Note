module NoteManager
  class Index < ApplicationService
    def initialize(user)
      @user = user
    end

    def execute
      @user.notes.includes(:folder)
        .with_attached_file.order_with_created_at
    end
  end
end
