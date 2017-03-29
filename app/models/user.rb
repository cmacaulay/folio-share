class User < ApplicationRecord
  has_secure_password

  has_many :folders
  has_many :uploads, through: :folders

  validates :username,        presence: true, uniqueness: true
  validates :cellphone,       presence: true, uniqueness: true
  validates :email,           presence: true, uniqueness: true
  validates :password_digest, presence: true

  def root_folder
    folders.find_by(parent_id: nil)
  end
end
