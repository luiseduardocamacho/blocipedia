class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    authorize @user
    respond_to do |format|
        format.html # show.html.erb
        format.xml { render :xml => @user }
    end

    def unsubscribe
      @user = User.find(params[:id])
      @user.role = "standard"
      if @user.save
        flash[:notice] = "You have successfully changed the role of your user to Standard "
      else
        flash[:notice] = "There was an error changing the role of your user"
      end
      redirect_to wikis_path
    end

  end
end
