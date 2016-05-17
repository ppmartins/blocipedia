class UsersController < ApplicationController
  def show
    @wiki = Wiki.new(user: current_user)
    @wikis = Wiki.where(user_id: current_user)
  end

  def update
    @user = current_user
    @user.role = 'member'
      if @user.save
        flash[:notice] = "Account downgraded successfully."
        redirect_to wikis_path
      else
        flash.now[:alert] = "Account failed to downgrade. Please try again."
        redirect_to wikis_path
      end
  end
end
