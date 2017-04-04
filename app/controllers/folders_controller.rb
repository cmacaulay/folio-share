class FoldersController < ApplicationController
  include PathsHelper
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

  def update
    folder = Folder.find(params[:id])
    if folder.change_privacy
      flash[:success] = "Success!"
    else
      flash[:danger] = "Something went wrong... Please try again."
    end
    redirect_to folder_or_folio_path(folder.parent.id)
  end

  private

  def folder_params
    params.require(:folder).permit(:name, :parent_id, :user_id)
  end
end
