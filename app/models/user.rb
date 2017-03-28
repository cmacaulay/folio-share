class User < ApplicationRecord
  has_many :folders
  has_many :uploads, through: :folders
end
