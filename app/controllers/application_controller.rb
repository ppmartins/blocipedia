class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    session[:previous_url] || wikis_path
  end


  private

  def user_not_authorized
    flash[:alert] = "Access denied"
    redirect_to root_path
  end
end
