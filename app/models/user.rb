class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :notes, foreign_key: :owner_id
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
end
