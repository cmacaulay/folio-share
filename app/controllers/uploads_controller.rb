class UploadsController < ApplicationController
  def new
    @upload = Upload.new
  end

  def create
    @folder = Folder.find(params[:upload][:folder_id])
    @upload = @folder.uploads.new(upload_params)
    if @upload.save
      flash[:success] = "Your file has been uploaded!"
    else
      flash[:danger] = "Please try uploading again"
    end
    redirect_to home_path
  end

  def show
    @upload = Upload.find(params[:id])
  end

  private

  def upload_params
    params.require(:upload).permit(:file)
  end
end
