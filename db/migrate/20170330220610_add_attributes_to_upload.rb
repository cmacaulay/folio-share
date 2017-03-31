class AddAttributesToUpload < ActiveRecord::Migration[5.0]
  def change
    add_column :uploads, :name, :string
    add_column :uploads, :content_type, :string
    add_column :uploads, :size, :integer
  end
end
