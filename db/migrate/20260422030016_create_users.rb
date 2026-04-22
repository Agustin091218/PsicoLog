class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users, id: :uuid do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :phone
      t.string :password_digest, null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :deleted_at 
  end
end