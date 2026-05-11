class CreateNotes < ActiveRecord::Migration[7.2]
  def change
    create_table :notes, id: :uuid do |t|
      t.references :patient, null: false, foreign_key: true, type: :uuid
      t.string :note_type, null: false
      t.text :content, null: false
      t.datetime :recorded_at, null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :notes, :deleted_at
    add_index :notes, :note_type
    add_index :notes, :recorded_at
  end
end
