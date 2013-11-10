class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @loggedInMessage = "Not logged in"
    if user_signed_in?
      
      @loggedInMessage = "Logged in"
      
      @allMonthlyNotes = @current_user.month_note_lists.to_a
      @allMonthlyNotes.sort_by! {|m| m[:date]}
      @allMonthlyNotes.reverse!
    end
  end
end
