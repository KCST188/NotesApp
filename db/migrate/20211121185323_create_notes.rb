class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.string :city
      t.string :note
      t.date :note_date
      t.integer :temperature

      t.timestamps
    end
  end
end
