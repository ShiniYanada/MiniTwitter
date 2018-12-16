class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :identifier
      t.string :email
      t.string :password_digest

      t.timestamps
    end

    add_index :users, :identifier, unique: true
    add_index :users, :email, unique: true
  end
end
