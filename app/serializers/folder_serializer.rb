class FolderSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :notes
end
