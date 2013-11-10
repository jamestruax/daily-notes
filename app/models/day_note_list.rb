class DayNoteList < ActiveRecord::Base
  has_many :notes
  belongs_to :month_note_list
  
  def add(note)
    self.notes.push(note)
  end

  def usedTags
    tags = Set.new
    
    self.notes.each do |n|
      tagsForNote = n.tags
      tagsForNote.each do |t|
        tags.add(t)
      end
    end
    tags
  end

end
