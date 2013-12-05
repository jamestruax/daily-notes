class NotesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @notes = Note.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @notes}
      format.json { render json: @notes}
    end
  end
  
  def new
    @tags = current_user.tags
    @note = Note.new
    @note.date = Date.today
    @note.time = Time.now.localtime
    @note.description = ""; 
    defaultTag = current_user.tags.detect { |t| t.name == "Sprint 2013-15" }
    if !defaultTag.nil? 
      @note.tags.push( defaultTag )
    end 
    defaultTag = current_user.tags.detect { |t| t.name == "Solar Lamp" }
    if !defaultTag.nil?
      @note.tags.push( defaultTag )
    end 
  end
  
  def create
    @note = Note.new(user_params)

    @monthList = current_user.findOrCreateForNote(@note)
      
    @dayList = @monthList.findOrCreateDayListForNote(@note)

    @note.day_note_list = @dayList
    
    if @note.save && @monthList.save && @dayList.save
      redirect_to controller: "home", action: "index"
    end
  end
  
  def show
    @note = Note.find(params[:id])
    @tags = current_user.tags
  end
  
  def showForDay
    @date = Note.find(params[:date])
    @tags = current_user.tags
  end

  def edit
    @note = Note.find(params[:id])
    @tags = current_user.tags
  end
  
  def update
    params[:note][:tag_ids] ||= []
    @note = Note.find(params[:id])
 
    if @note.update(user_params)
      m = current_user.findOrCreateForNote(@note)
      d = m.findOrCreateDayListForNote(@note)
      @note.day_note_list = d
      m.save
      d.save
      @note.save
      redirect_to controller: "home", action: "index"
    else
      render 'edit'
    end
  end

  def destroy
    @note = Note.find(params[:id])
    dayList = @note.day_note_list
    
    if (dayList.notes.size == 1 && dayList.notes[0].id == @note.id)
      # Deleting the Note will leave the DayNoteList empty 
      
      monthList = dayList.month_note_list
      
      if (monthList.day_note_lists.size == 1 && monthList.day_note_lists[0].id == dayList.id)
        # Deleteing the DayNoteList will leave the MonthNoteList empty
        monthList.destroy
      end
      dayList.destroy
    end

    @note.destroy



    respond_to do |format|
      format.html { redirect_to controller: "home", action: "index" }
      format.xml  { head :ok }
    end
  end
  
  private

  def user_params
    params.require(:note).permit(:date, :time, :description, :tag_ids => [])
  end
end
