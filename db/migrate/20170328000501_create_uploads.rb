class CreateUploads < ActiveRecord::Migration[5.0]
  def change
    create_table :uploads do |t|
      t.integer :status
      t.string :name
      t.references :folder, foreign_key: true

      t.timestamps null: false
    end
  end
end
