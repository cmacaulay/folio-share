class AddSlugToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :slug, :string
  end
end
