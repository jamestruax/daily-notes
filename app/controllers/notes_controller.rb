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
    @tags = Tag.find(:all)
    @note = Note.new
    @note.date = Date.today
    @note.time = Time.now
    @note.description = ""; 
    defaultTag = Tag.find(:all).detect { |t| t.name == "Sprint 2013-13" }
    @note.tags.push( defaultTag ) 
    defaultTag = Tag.find(:all).detect { |t| t.name == "Research" }
    @note.tags.push( defaultTag ) 
  end
  
  def create
    @note = Note.new(user_params)
    @note.owner = current_user
    if @note.save
      redirect_to controller: "home", action: "index"
    end
  end
  
  def show
    @note = Note.find(params[:id])
    @tags = Tag.find(:all)
  end
  
  def edit
    @note = Note.find(params[:id])
    @tags = Tag.find(:all)
  end
  
  def update
    params[:note][:tag_ids] ||= []
    @note = Note.find(params[:id])
 
    if @note.update(user_params)
      redirect_to controller: "home", action: "index"
    else
      render 'edit'
    end
  end
  
  private

  def user_params
    params.require(:note).permit(:date, :time, :description, :tag_ids => [])
  end
end
