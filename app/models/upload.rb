class Upload < ApplicationRecord
  mount_uploader :attachment, AttachmentUploader

  belongs_to :folder
  delegate :user, to: :folder
  has_many :comments

  # validates :attachment, presence: true, file_size: { maximum: 2.gigabytes }

#   validates :attachment, presence: true

  validates :name, presence: true
  validates :content_type, presence: true
  validates :size, presence: true
  validates :folder_id, presence: true

end
