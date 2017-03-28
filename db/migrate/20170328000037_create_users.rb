class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.integer :role, default: 0
      t.string :cellphone
      t.string :email
      t.string :password_digest
      t.integer :status, default: 0
      t.string :token

      t.timestamps null: false
    end
  end
end
