class Folders::CollaborationsController < ApplicationController
  before_action :current_folder

  def new
    @share  = Folder.find(params[:folder_id]).collaborations.new
  end

  def create
    @share  = Folder.find(params[:folder_id]).collaborations.new
    @share.user = User.find_by_username(params[:collaboration][:user])
    if @share.save
      flash[:success] = "You shared #{@share.folder.name} with #{@share.user.username}!"
      redirect_to folder_path(@share.folder)
    else
      flash[:danger] = "User not found, please try again."
      redirect_to folder_share_path(@share.folder)
    end
  end

end
