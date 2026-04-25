class CreatePatients < ActiveRecord::Migration[7.2]
  def change
    create_table :patients, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email
      t.string :phone
      t.date :birth_date
      t.datetime :deleted_at

      t.timestamps
    end
    
    add_index :patients, :deleted_at
  end
end