class RemoveNameFromUploads < ActiveRecord::Migration[5.0]
  def change
    remove_column :uploads, :name
  end
end
