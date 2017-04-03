class Folders::CollaborationsController < ApplicationController
  before_action :current_folder

  def new
    @collaboration  = current_folder.collaborations.new
  end

  def create
    @collaboration  = current_folder.collaborations.new
    @collaboration.user = User.find_by_username(params[:collaboration][:user])
    if @collaboration.save
      flash[:success] = "You shared #{current_folder.name} with #{@collaboration.user.username}!"
      redirect_to folder_path(current_folder)
    else
      flash[:danger] = "User not found, please try again."
      redirect_to folder_share_path(current_folder)
    end
  end

end
