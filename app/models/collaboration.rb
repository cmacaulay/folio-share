class Collaboration < ApplicationRecord
  belongs_to :user
  belongs_to :folder

  validates_uniqueness_of :user_id, scope: :folder_id

  def save_children
    arr = []
    folder.children.each do |child|
      save_nested_children(folder) if child.class == Folder
    end
    byebug
  end

  def save_nested_children(folder)
    [] << folder.id
    folder.save_children if folder.children 
  end
end
