class CreateCollaborators < ActiveRecord::Migration[5.0]
  def change
    create_table :collaborators do |t|
      t.references :user, foreign_key: true
      t.references :folder, foreign_key: true

      t.timestamps null: false
    end
  end
end
