class NoteSerializer
  include FastJsonapi::ObjectSerializer
  attributes :body, :file_url, :folder
end
