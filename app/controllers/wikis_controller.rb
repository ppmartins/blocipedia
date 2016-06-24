class WikisController < ApplicationController
  before_filter :set_collaborators, only: [:new, :edit]

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
    @selected_collaborator = nil
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    @wiki.private = false if current_user.role == 'member'
    @wiki.save
    @wiki.collaborators.create(wiki_id: @wiki.id, user_id: params[:wiki][:user_id])

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @selected_collaborator = @wiki.collaborators.first.user_id
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.update_attributes(wiki_params)

    authorize @wiki
    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end


  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

  def set_collaborators
    @collaborators = User.all
  end
end
