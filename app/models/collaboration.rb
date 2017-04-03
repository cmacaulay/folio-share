class Collaboration < ApplicationRecord
  belongs_to :user
  belongs_to :folder

  validates_uniqueness_of :user_id, scope: :folder_id 
end
