class CreateFolders < ActiveRecord::Migration[5.0]
  def change
    create_table :folders do |t|
      t.string :name
      t.integer :status
      t.references :user
      t.integer :parent_id

      t.timestamps null: false
    end
  end
end
