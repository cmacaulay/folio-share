class FoldersController < ApplicationController
before_action :authorize!

  def show
    @current_folder = Folder.find(params[:id])
    @file = Upload.new
  end

  def new
    @current_folder = Folder.find(params[:id])
    @folder = Folder.new
  end

  def create
    @folder = Folder.new(folder_params)
    if @folder.save
      flash[:success] = "#{@folder.name} Successfully Created"
      redirect_to folder_path(@folder)
    else
      @current_folder = Folder.find(params[:id])
      flash[:danger] = "Incorrect Entry"
      redirect_to new_folder_path(@current_folder)
    end
  end

  def destroy
    byebug
    @folder = Folder.find(params[:id])
    if current_user.admin? || current_user.id == @folder.user_id
      @folder.destroy
      flash[:danger] = "Folder deleted."
      if current_user.admin?
        redirect_to admin_dashboard_path
      else
        redirect_to home_path
      end
    else
      flash[:danger] = "Folder not deleted."
      redirect_to home_path
    end
  end

  private

  def folder_params
    params.require(:folder).permit(:name, :parent_id, :user_id)
  end
end
