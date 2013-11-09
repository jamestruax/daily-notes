class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @loggedInMessage = "Not logged in"
    if user_signed_in?
      @loggedInMessage = "Logged in"
      
      #@notes = @current_user.allNotesSorted
      @data = @current_user.allNotesSortedAndGroupedByMonth
    end
  end
end
