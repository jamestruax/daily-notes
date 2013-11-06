class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :description
      t.date :date
      t.time :time
      t.integer :owner_id

      t.timestamps
    end
  end
end
