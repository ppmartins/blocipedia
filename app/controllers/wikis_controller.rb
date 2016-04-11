class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:user_id])
  end

  def new
    @wikis = Wiki.new
  end

  def create
    def create
      @wiki = Wiki.new
      @wiki.title = params[:wiki][:title]
      @wiki.body = params[:wiki][:body]
      @wiki.boolean = params[:wiki][:boolean]

      if @wiki.save
        flash[:notice] = "Wiki was saved."
        redirect_to user_wikis
      else
        flash.now[:alert] = "There was an error saving the wiki. Please try again."
        redirect_to new_user_wiki
      end
    end
  end

  def edit
  end
end
