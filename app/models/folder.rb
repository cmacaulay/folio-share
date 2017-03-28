class Folder < ApplicationRecord
  belongs_to :user
  belongs_to :parent, :class_name => 'Folder', optional: true
  has_many :children, :class_name => 'Folder', :foreign_key => 'parent_id'
  has_many :uploads

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
end
