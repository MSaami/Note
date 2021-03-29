module NoteManager
  class Destroy < ApplicationService
    def initialize(note_id)
      @note_id = note_id
    end

    def execute
      note = Note.find(@note_id)
      note.destroy
    end
  end
end
