class Folder < ApplicationRecord
  # belongs_to :user
  belongs_to :owner, class_name: "User", foreign_key: "user_id", required: false
  belongs_to :parent, class_name: "Folder", optional: true

  has_many :subfolders, class_name: "Folder", foreign_key: "parent_id"
  has_many :uploads
  has_many :collaborations, dependant: :destroy
  has_many :collaborators, through: :collaborations, source: :user

  validates :name,   presence: true
  validates :status, presence: true

  enum ({status: [:active, :inactive]})

  def ancestors
    ancestors = [self]
    unless parent_id.nil?
      ancestors.concat(Folder.find(parent_id).ancestors)
    end
    ancestors
  end

  def children
    children = subfolders.to_a.concat(uploads.to_a)
    children.sort_by { |child| child.name.downcase }
  end

  def root_folder?
    parent.nil?
  end

  def content_type
    ""
  end

  def size
    ""
  end
end
