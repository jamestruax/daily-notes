class Note < ActiveRecord::Base
  belongs_to :day_note_list
  has_and_belongs_to_many :tags
  
  def self.notesSortedAndGroupedByMonth(notes)
    
    # nMonths = data.size
    # date = data[i][:date]
    # days = data[i][:days]
    # nDays = days.size
    # dayDate = days[i][:date]
    # notes = days[i][:notes]
    
    # Create a set of dates
    h = Hash.new
    tmpNote = notes
    tmpNote.each do |note|
      date = note.date

      dateToHash = Date.new(date.year, date.month, 1)

      if (h.has_key?(dateToHash))
        h[dateToHash].push( note );
      else
        array = Array.new
        array.push( note );
        h[dateToHash] = array;
      end
    end
      
    finalArray = Array.new

    # Sorted list of Dates
    sortedKeys = h.keys.sort {|a,b| b<=>a }
    
    sortedKeys.each do |key|  # key is Month
      days = Note.notesSortedAndGroupedByDay(h[key])

      finalHash = Hash.new
      finalHash[:date] = key     # Month/Year
      finalHash[:days] = days    # Array of Notes
    
      finalArray.push( finalHash )
    end

    finalArray
  end

  def self.notesSortedAndGroupedByDay(notes)
    
    # notes: All notes should have the same month/year
    
    # Create a set of dates
    h = Hash.new
    tmpNote = notes
    tmpNote.each do |note|
      date = note.date

      dateToHash = Date.new(1, 1, date.day)

      if (h.has_key?(dateToHash))
        h[dateToHash].push( note );
      else
        array = Array.new
        array.push( note );
        h[dateToHash] = array;
      end
    end
      
    finalArray = Array.new

    # Sorted list of Dates
    sortedKeys = h.keys.sort {|a,b| b<=>a }
    
    sortedKeys.each do |key|  # key is Month
      finalHash = Hash.new
      finalHash[:date]  = h[key][0].date # Month/Year
      finalHash[:notes] = h[key]         # Array of Notes
      
      finalArray.push( finalHash )
    end

    finalArray
  end

  def summarize
    str = String.new
    str = self.description.slice(0, 50)
    str += " ..."
    str
  end
end
