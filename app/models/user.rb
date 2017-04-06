class User < ApplicationRecord
  has_secure_password
  has_many :comments
  has_many :folders
  has_many :uploads, through: :folders
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :collaborations, dependent: :destroy
  has_many :shared_on, through: :collaborations, source: :folder

  validates :username, :email, :cellphone, presence: true, uniqueness: true
  validates :first_name, :last_name, :password_digest, presence: true

  after_create :create_root, :registered_user

  enum status: [:activated, :deactivated]

  def root_folder
    folders.find_by(parent_id: nil)
  end

  def create_root
    folders.create!(name: "Folio")
  end

  def create_reset_digest
    password_token = rand(1000..10000).to_s
    self.update_attribute(:reset_token, password_token)
    self.save
  end

  def admin?
    roles.exists?(name: "admin")
  end

  def activated_user?
    self.status == "activated"
  end

  def deactivated_user?
    self.status == "deactivated"
  end

  def registered_user
    role = Role.find_or_create_by(name: 'registered user')
    self.roles << role
  end

  def activate
    self.update(status: "activated")
  end

  def deactivate
    self.update(status: "deactivated")
  end

  def full_name
    first_name.capitalize + " " + last_name.capitalize
  end
end
