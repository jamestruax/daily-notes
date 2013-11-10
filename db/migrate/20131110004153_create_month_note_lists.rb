class CreateMonthNoteLists < ActiveRecord::Migration
  def change
    create_table :month_note_lists do |t|
      t.references :owner
      t.date :date

      t.timestamps
    end
  end
end
