class User < ApplicationRecord
  has_secure_password

  has_many :notes
  has_many :folders

  validates :email, presence: true, uniqueness: true


  def default_folder
    folders.find_by_name('default')
  end

end
