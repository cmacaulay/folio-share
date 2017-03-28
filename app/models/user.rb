class User < ApplicationRecord
  has_many :folders
  has_many :uploads, through: :folders

  def root_folder
    folders.where(parent_id: 0)
  end
end
