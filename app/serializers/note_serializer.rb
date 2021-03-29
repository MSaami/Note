class NoteSerializer
  include FastJsonapi::ObjectSerializer
  attributes :body, :file_url, :created_at, :folder
end
