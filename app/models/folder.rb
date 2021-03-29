class Folder < ApplicationRecord
  belongs_to :user
  has_many :notes

  validates :name, presence: true
  validates :user, presence: true
end
