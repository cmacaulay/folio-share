class FoldersController < ApplicationController
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

  private

  def folder_params
    params.require(:folder).permit(:name, :parent_id, :user_id)
  end
end
