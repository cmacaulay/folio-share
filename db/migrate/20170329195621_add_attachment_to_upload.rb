class AddAttachmentToUpload < ActiveRecord::Migration[5.0]
  def change
    add_column :uploads, :attachment, :string
  end
end
