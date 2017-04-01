class UploadsController < ApplicationController
  def new
    @upload = current_folder.uploads.new
  end

  def create
    @upload = current_folder.uploads.new(upload_params)
    if @upload.save
    folder = Folder.find(params[:upload][:folder_id])
    upload = Upload.new(upload_params)
    if upload.save
      flash[:success] = "Your file has been uploaded!"
      redirect_to home_path
    else
      flash[:danger] = "Please try uploading again"
      redirect_to home_path
    end
  end

  def show
    @upload = Upload.find(params[:id])
  end

  private

  def upload_params
    params.require(:upload).permit(:folder_id, :attachment)
  end
end
