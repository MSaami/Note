class Note < ApplicationRecord
  has_one_attached :file
  belongs_to :user
  belongs_to :folder

  validates :user, presence: true
  validates :body, presence: true
  validates :folder, presence: true

  def file_url
    Rails.application.routes.url_helpers.rails_blob_path(file, only_path: true) if file.attached?
  end

end
