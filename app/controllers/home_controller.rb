class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @loggedInMessage = "Not logged in"
    if user_signed_in?
      
      @loggedInMessage = "Logged in"
      
      @allMonthlyNotes = @current_user.displayedMonths
    end
  end
end
