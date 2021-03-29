class Note < ApplicationRecord
  has_one_attached :file
  belongs_to :user
  belongs_to :folder

  validates :user, presence: true
  validates :body, presence: true
  validates :folder, presence: true

  scope :with_attached_file, -> { includes(file_attachment: :blob) }
  scope :order_with_created_at, -> { order(created_at: :desc) }

  def file_url
    Rails.application.routes.url_helpers.rails_blob_path(file, only_path: true) if file.attached?
  end

end
