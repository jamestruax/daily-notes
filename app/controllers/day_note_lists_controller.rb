class DayNoteListsController < ApplicationController
  def index
    
  end

  def show
    @dayList = DayNoteList.find(params[:id])
  end
end
