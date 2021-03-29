class Note < ApplicationRecord
  belongs_to :user
  belongs_to :folder

  validates :user, presence: true
  validates :body, presence: true
  validates :folder, presence: true
end
