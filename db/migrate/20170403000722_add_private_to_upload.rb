class AddPrivateToUpload < ActiveRecord::Migration[5.0]
  def change
    add_column :uploads, :is_private, :boolean, default: true
  end
end
