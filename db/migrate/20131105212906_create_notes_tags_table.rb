class CreateNotesTagsTable < ActiveRecord::Migration
  def change
    create_table :notes_tags do |t|
        t.belongs_to :tag
        t.belongs_to :note
    end
  end
end
