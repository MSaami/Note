module Api::V1
  class NotesController < BaseController
    before_action :check_policy, only: [:update, :destroy]
    before_action :can_create_note?, only: [:create]

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

    def check_policy
      Policy::NoteAccess.call(@current_user, params[:id])
    end

    def can_create_note?
      Policy::FolderAccess.call(@current_user, permit_params[:folder_id])
    end
  end
end
