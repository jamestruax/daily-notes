class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @loggedInMessage = "Not logged in"
    if user_signed_in?
      
      @loggedInMessage = "Logged in"
      
      #@notes = @current_user.allNotesSorted
      @allMonthlyNotes = @current_user.month_note_lists
      
      @dates = Set.new
      
      @notes = Array.new
      @current_user.month_note_lists.each do |month|
        dayLists = month.day_note_lists.each do |day|
          day.notes.each do |note|
            @notes.push( note )
            @dates.add( note.date )
          end
        end
      end
    end
  end
end
