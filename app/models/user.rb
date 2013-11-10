class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :notes, foreign_key: :owner_id
  has_many :month_note_lists, foreign_key: :owner_id
  has_many :tags, foreign_key: :owner_id

  def allNotesSorted
    # Create a set of dates
    h = Hash.new
    tmpNote = self.notes
    tmpNote.each do |note|
      d = note.date
      t = note.time
      dt = DateTime.new(d.year, d.month, d.day, t.hour, t.min, t.sec)

      h[dt] = note
    end
      
    sortedKeys = h.keys.sort {|a,b| b<=>a }
    
    notes = Array.new
    sortedKeys.each do |key|
      notes.push( h[key])
    end
    notes
  end 

  def allNotesSortedAndGroupedByMonth
    Note.notesSortedAndGroupedByMonth(self.notes)
  end

  def findOrCreateForNote(note)
    found = nil;
    self.month_note_lists.find(:all).each do |m|
      if (m.date.month == note.date.month &&
          m.date.year == note.date.year)
        found = m
      end
    end

    if found.nil?
      found = MonthNoteList.new
      found.owner_id = self.id
      found.date = Date.new(note.year, note.month, 1)
      debugger
    end

    found
  end
end
