class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @loggedInMessage = "Not logged in"
    if user_signed_in?
      @loggedInMessage = "Logged in"
      
      # Create a set of dates
      @h = Hash.new
      @tmpNote = current_user.notes
      @tmpNote.each do |note|
        d = note.date
        t = note.time
        dt = DateTime.new(d.year, d.month, d.day, t.hour, t.min, t.sec)

        @h[dt] = note
      end
      
      @sortedKeys = @h.keys.sort {|a,b| b<=>a }
      
      @notes = Array.new
      @sortedKeys.each do |key|
        @notes.push( @h[key])
      end
      
      #@notes.reverse!
      
      #@notes = current_user.notes.sort_by! {|n| n.date.jd}
      #@notes.reverse!
    end
  end
end
