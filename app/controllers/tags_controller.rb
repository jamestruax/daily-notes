class TagsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @tags = current_user.tags
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @tags}
      format.json { render json: @tags}
    end
  end
  
  def new
    @tag = Tag.new
    @tag.owner = current_user
    if (params.has_key?(:name)) 
        @tag.name = "Default"
    end
  end
  
  def create
    @tag = Tag.new(user_params)
    @tag.owner = current_user
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
  
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to(tags_url) }
      format.xml  { head :ok }
    end
  end
  
  private

  def user_params
    params.require(:tag).permit(:name)
  end
end
