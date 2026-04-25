class CreateNotes < ActiveRecord::Migration[7.2]
  def change
    create_table :notes, id: :uuid do |t|
      t.references :patient, null: false, foreign_key: true, type: :uuid
      t.string :note_type, null: false
      t.datetime :recorded_at, null: false
      t.text :content, null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :notes, :deleted_at
  end
end