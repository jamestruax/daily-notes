class CreateDayNoteLists < ActiveRecord::Migration
  def change
    create_table :day_note_lists do |t|
      t.references :month_note_list
      t.date :date

      t.timestamps
    end
  end
end
