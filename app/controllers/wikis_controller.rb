class WikisController < ApplicationController

before_action :authenticate_user!, except: [:index, :show]

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user

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
      authorize @wiki
  end

  def update
      @wiki = Wiki.find(params[:id])
      #@wiki.assign_attributes(wiki_params)
      authorize @wiki
      if @wiki.update(wiki_params)
        flash[:notice] = "Wiki was saved."
        redirect_to @wiki
      else
        flash.now[:alert] = "There was an error saving the wiki. Please try again."
        render :edit
      end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.delete
      flash[:notice] =  "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :show
    end
  end

  def collaborators
    @wiki = Wiki.find(params[:id])
    @allusers = User.all
    # params[user_ids][].each |id|
        # add the ones checked
    #   Collaboration.create user_id: id, wiki_id: @wiki.id
        # remove the ones not checked
     #end
  end

  def add_collaborators
    @wiki = Wiki.find(params[:id])
    @user = User.find(params[:user_id])
    if Collaboration.create user_id: @user.id, wiki_id: @wiki.id
      flash[:notice] =  "\"#{@user.name}\" was added successfully."
      redirect_to @wiki
    else
      flash[:notice] =  "there was a problem adding \"#{@user.name}\" as a collaborator"
      redirect_to @wiki
    end
  end

  def remove_collaborators
    @wiki = Wiki.find(params[:id])
    @user = User.find(params[:user_id])
    @collaborator = Collaboration.where(user_id: @user , wiki_id: @wiki.id).first
    if @collaborator.destroy
      flash[:notice] =  "\"#{@user.name}\" was removed successfully."
      redirect_to @wiki
    else
      flash[:notice] =  "there was a problem removing \"#{@user.name}\" as a collaborator"
      redirect_to @wiki
    end
  end

  def collaborators?
    @wiki = Wiki.find(params[:id])
    @user = User.find(params[:user_id])

  end

  private

    def wiki_params
      params.require(:wiki).permit(:title, :body, :private)
    end


end
