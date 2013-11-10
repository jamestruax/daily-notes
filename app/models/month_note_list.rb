class MonthNoteList < ActiveRecord::Base
  belongs_to :owner, class_name: User
  has_many :day_note_lists
    
  def findOrCreateDayListForNote(note)
    found = nil;
    self.day_note_lists.find(:all).each do |day|
      if (day.date == note.date)
        found = day
      end
    end

    if found.nil?
      found = DayNoteList.new
      found.date = note.date
      found.month_note_list = self;

    end
    found
  end
  
  def add(note)
    self.day_note_lists.find(:all).each do |day|
      if (day.date == note.date)
        day.add(note)
      end
    end
  end

  def displayedDays
    monthList = self.day_note_lists.sort_by! { |day| day[:date] }
    monthList.reverse!
    monthList
  end 
end
