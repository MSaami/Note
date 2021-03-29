module NoteManager
  class Index < ApplicationService
    def initialize(user)
      @user = user
    end

    def execute
      @user.notes.includes(:folder)
    end
  end
end
