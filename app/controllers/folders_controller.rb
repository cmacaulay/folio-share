class FoldersController < ApplicationController
  def show
    @file = Upload.new
    @folder = Folder.find(params[:id])
    session[:current_folder_id] = params[:id]
  end

  def new
    @folder = Folder.new
  end

  def create
    @folder = Folder.new(folder_params)
    if @folder.save
      flash[:success] = "#{@folder.name} Successfully Created"
      if current_folder
        redirect_to folder_path(current_folder)
      else
        redirect_to home_path
      end
    else
      flash[:danger] = "Incorrect Entry"
      render :new
    end
  end

  private

  def folder_params
    params.require(:folder).permit(:name, :user_id, :parent_id)
  end
end
