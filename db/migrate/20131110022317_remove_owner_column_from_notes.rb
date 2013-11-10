class RemoveOwnerColumnFromNotes < ActiveRecord::Migration
  def change
    remove_column :notes, :owner_id, :integer
    add_column :notes, :day_note_list_id, :integer, :references => "dayNoteLists"
  end
end
