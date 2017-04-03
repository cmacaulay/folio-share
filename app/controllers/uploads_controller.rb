class UploadsController < ApplicationController
  def create
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
    @comment = Comment.new
    @comment.upload_id = @upload.id
  end

  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy
    if current_user.admin? || current_user.id == @upload.folder.owner.id
      flash[:danger] = "File deleted."
      if current_user.admin?
        redirect_to admin_dashboard_path
      else
        redirect_to home_path
      end 
    else
      flash[:danger] = "File deleted."
      redirect_to home_path
    end
  end

  private

  def upload_params
    params.require(:upload).permit(:folder_id, :attachment)
  end
end
