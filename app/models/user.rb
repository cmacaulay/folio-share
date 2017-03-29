class User < ApplicationRecord
  has_secure_password

  has_many :folders
  has_many :uploads, through: :folders

  validates :username, :email, :cellphone, presence: true, uniqueness: true
  validates :first_name, :last_name, :password_digest, presence: true

  after_create :create_root

  def root_folder
    folders.find_by(parent_id: nil)
  end

  def create_root
    folders.create!(name: "#{first_name}'s Folder")
  end
end
