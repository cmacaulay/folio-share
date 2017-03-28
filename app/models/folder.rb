class Folder < ApplicationRecord
  belongs_to :user
  has_many :children, :class_name => 'Folder', :foreign_key => 'parent_id'
  belongs_to :parent, :class_name => 'Folder', optional: true
  has_many :uploads

  def ancestors
    ancestors = [self]
    unless parent_id.zero?
      ancestors.concat(Folder.find(parent_id).ancestors)
    end
    ancestors
  end
end
