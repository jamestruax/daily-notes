class TagsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @tags = Tag.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @tags}
      format.json { render json: @tags}
    end
  end
  
  def new
    @tag = Tag.new
    if (params.has_key?(:name)) 
        @tag.name = "Default"
    end
  end
  
  def create
    @tag = Tag.new(user_params)
    if @tag.save
      redirect_to controller: "home", action: "index"
    end
  end
  
  def show
    @tag = Tag.find(params[:id])
  end
  
  def edit
    @tag = Tag.find(params[:id])
  end
  
  def update
    @tag = Tag.find(params[:id])
 
    if @tag.update(user_params)
      redirect_to controller: "home", action: "index"
    else
      render 'edit'
    end
  end
  
  private

  def user_params
    params.require(:tag).permit(:name)
  end
end
