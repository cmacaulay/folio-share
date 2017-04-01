class Folder < ApplicationRecord
  belongs_to :user
  belongs_to :parent, class_name: "Folder", optional: true
  has_many :subfolders, class_name: "Folder", foreign_key: "parent_id"
  has_many :uploads

  validates :name,   presence: true
  validates :status, presence: true

  enum ({status: [:active, :inactive]})

  def ancestors(list = [])
    unless parent_id.nil?
      list.unshift(parent)
      parent.ancestors(list)
    end
    list
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
