class AddFileUploadToUpload < ActiveRecord::Migration[5.0]
  def change
    add_attachment :uploads, :file
  end
end
