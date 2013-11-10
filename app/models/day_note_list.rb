class DayNoteList < ActiveRecord::Base
  has_many :notes
  belongs_to :month_note_list
  
  def add(note)
    self.notes.push(note)
  end
end
