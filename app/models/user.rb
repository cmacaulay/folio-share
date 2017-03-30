class User < ApplicationRecord
  has_secure_password

  has_many :comments
  has_many :folders
  has_many :uploads, through: :folders

  validates :username, :email, :cellphone, presence: true, uniqueness: true
  validates :first_name, :last_name, :password_digest, presence: true

  before_validation :assign_slug
  after_create :create_root

  def assign_slug
    self.slug = self.username.parameterize if self.username
  end

  def root_folder
    folders.find_by(parent_id: nil)
  end

  def create_root
    folders.create!(name: "Folio")
  end

  def full_name
    first_name + " " + last_name
  end
end
