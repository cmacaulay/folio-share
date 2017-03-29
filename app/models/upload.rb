class Upload < ApplicationRecord
  before_validation :check
  belongs_to :folder
  # belongs_to :user, through: :folder
  has_attached_file :file
  validates_attachment_content_type :file, content_type: all

  def check
    # byebug
  end

  def size
    "200TB"
  end

  def file_type
    "PDF"
  end
end
