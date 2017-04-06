class Upload < ApplicationRecord
  include PrivacySettings

  mount_uploader :attachment, AttachmentUploader

  belongs_to :folder
  has_many :comments, dependent: :destroy
  delegate :user, to: :folder

  validates :attachment, presence: true
  validates :name, presence: true
  validates :content_type, presence: true
  validates :size, presence: true
  validates :folder_id, presence: true

  alias_attribute :owner, :user
  alias_attribute :parent, :folder

  def all_uploads
    [self]
  end

  def ancestors
    folder.ancestors << folder
  end

  def directory
    ancestors.map(&:name).join("/")
  end

  def folio_filepath
    "#{directory}/#{name}"
  end

  def local_filepath
    attachment.file.file
  end

  def owner_id
    self.folder.owner.id
  end

  def self.public_uploads
    Upload.where(is_private: false)
  end

  def user_activated?
    self.folder.user.activated?
  end

end
