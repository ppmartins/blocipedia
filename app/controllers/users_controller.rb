class UsersController < ApplicationController
  def show
    @wiki = Wiki.new(user: current_user)
    @wikis = Wiki.where(user_id: current_user)
  end
end
