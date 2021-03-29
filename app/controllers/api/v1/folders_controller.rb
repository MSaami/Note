module Api::V1
  class FoldersController < BaseController
    def index
      folders = FolderManager::Index.call(@current_user)
      render json: FolderSerializer.new(folders).serialized_json
    end

    def create
      folders = FolderManager::Create.call(permit_params[:name], @current_user)
      head :created
    end

    private
    def permit_params
      params.require(:folder).permit(:name)
    end
  end
end
