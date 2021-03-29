module Api::V1
  class NotesController < BaseController

    def index
      notes = NoteManager::Index.call(@current_user)
      render json: NoteSerializer.new(notes).serialized_json
    end

    def create
      NoteManager::Create.call(permit_params, @current_user)
      head :created
    end

    def update
      NoteManager::Update.call(params[:id], permit_params)
      head :no_content
    end

    def destroy
      NoteManager::Destroy.call(params[:id])
      head :no_content
    end

    private
    def permit_params
      params.require(:note).permit(:body, :folder_id, :file)
    end
  end
end
