class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  helper_method :current_folder

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_folder
    @current_folder ||= Folder.find(session[:current_folder_id]) if session[:current_folder_id]
  end
end
