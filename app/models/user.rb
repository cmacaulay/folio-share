class User < ApplicationRecord
  has_secure_password
  has_many :comments
  has_many :folders
  has_many :uploads, through: :folders

  validates :first_name,      presence: true
  validates :last_name,       presence: true
  validates :cellphone,       presence: true, uniqueness: true
  validates :email,           presence: true, uniqueness: true
  validates :password_digest, presence: true

  after_create :create_root

  def root_folder
    folders.find_by(parent_id: nil)
  end

  def create_root
    folders.create!(name: "#{first_name}'s Folder")
  end
end
