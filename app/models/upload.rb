class Upload < ApplicationRecord
<<<<<<< HEAD
  has_attached_file :file
=======
  before_validation :check
>>>>>>> 239bbedd7b97dd1ce5ace6184f3bfcb8ae7f9470
  belongs_to :folder
  # belongs_to :user, through: :folder
  has_attached_file :file
  validates_attachment_content_type :file, content_type: all

  def check
    # byebug
  end

  alias_attribute :name, :file_file_name
  alias_attribute :content_type, :file_content_type
  alias_attribute :size, :file_file_size
end
