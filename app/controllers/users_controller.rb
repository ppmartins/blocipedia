class UsersController < ApplicationController
  def show
    @wiki = Wiki.new(user: current_user)
    @wiki = Wiki.where(user_id: current_user)
  end
end
