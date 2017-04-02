class User < ApplicationRecord
  has_secure_password
  has_many :comments #, dependant: :destroy -- do we want comments to be destroyed if a user is?
  has_many :folders
  has_many :uploads, through: :folders
  has_many :user_roles
  has_many :roles, through: :user_roles

  has_many :collaborations, dependent: :destroy
  has_many :collaborators, through: :collaborations, source: :folder

  validates :username, :email, :cellphone, presence: true, uniqueness: true
  validates :first_name, :last_name, :password_digest, presence: true

  after_create :create_root

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

  def registered_user
    role = Role.find_by(name: 'registered user')
    self.roles << role
  end

  
end
