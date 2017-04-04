class AddIsPrivateToFolders < ActiveRecord::Migration[5.0]
  def change
    add_column :folders, :is_private, :boolean, default: true
  end
end
