class FoldersController < ApplicationController
  def show
    @folder = Folder.find(params[:id])
  end

  def new
    @folder = Folder.new
  end

  def create
    @folder = Folder.new(folder_params)
    if @folder.save
      flash[:success] = "#{@folder.name} Successfully Created"
      redirect_to home_path
    else
      flash[:danger] = "You Suck"
      render :new
    end
  end

  private

  def folder_params
    params.require(:folder).permit(:name, :user_id, :parent_id)
  end
end
