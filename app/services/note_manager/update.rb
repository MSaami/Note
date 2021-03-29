module NoteManager
  class Update < ApplicationService
    def initialize(note_id, params)
      @note_id = note_id
      @params = params
    end

    def execute
      note = Note.find(@note_id)
      note.update!(@params)
    end
  end
end
