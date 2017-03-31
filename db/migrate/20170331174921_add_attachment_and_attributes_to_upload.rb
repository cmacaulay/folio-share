class AddAttachmentAndAttributesToUpload < ActiveRecord::Migration[5.0]
  def change
    add_column :uploads, :name, :string
    add_column :uploads, :content_type, :string
    add_column :uploads, :size, :integer
    add_column :uploads, :attachment, :string
  end
end
