class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.references :upload, foreign_key: true
      t.string :content

      t.timestamps null: false 
    end
  end
end
