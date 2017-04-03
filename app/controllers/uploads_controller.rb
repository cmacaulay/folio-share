class UploadsController < ApplicationController
  def create
    folder = Folder.find(params[:upload][:folder_id])
    upload = Upload.new(upload_params)
    if upload.save
      flash[:success] = "Your file has been uploaded!"
      redirect_to folio_path
    else
      flash[:danger] = "Please try uploading again"
      redirect_to folio_path
    end
  end

  def show
    @upload = Upload.find(params[:id])
    @comment = Comment.new
    @comment.upload_id = @upload.id
  end

  def update
    upload = Upload.find(params[:format])
    upload.change_privacy
    if upload.save
      flash[:success] = "Your file has been uploaded!"
    else
      flash[:danger] = "Please try uploading again"
    end
    if Folder.find_by(user: current_user, id: params[:id])
      redirect_to folio_path
    else
      redirect_to folder_path(Folder.find(params[:id]))
    end
  end

  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy
    if current_user.admin?
      flash[:danger] = "File deleted."
      redirect_to admin_dashboard_path
    else
      flash[:danger] = "File deleted."
      redirect_to folio_path
    end
  end

  private

  def upload_params
    params.require(:upload).permit(:folder_id, :attachment)
  end
end
