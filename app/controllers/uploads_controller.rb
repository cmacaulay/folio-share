class UploadsController < ApplicationController
  include PathsHelper

  def create
    folder = Folder.find(params[:upload][:folder_id])
    upload = Upload.new(upload_params)
    binding.pry
    if upload.save
      flash[:success] = "Your file has been uploaded!"
    else
      flash[:danger] = "Please try uploading again."
    end
    redirect_to folder_or_folio_path(folder)
  end

  def show

    @upload = Upload.find(params[:id])
    session[:current_folder_id] = @upload.folder.id if session[:current_folder_id].nil?
    @comment = Comment.new
    @comment.upload_id = @upload.id
  end

  def update
    upload = Upload.find(params[:id])
    upload.change_privacy
    flash[:success] = "Success!"
    redirect_to folder_or_folio_path(upload.folder)
  end

  def destroy
    @upload = Upload.find(params[:id])
    if current_user.admin? || current_user.id == @upload.owner_id
      @upload.destroy
      flash[:danger] = "File successfully deleted."
      if current_user.admin?
        redirect_to admin_dashboard_path
      else
        redirect_to folio_path
      end
    else
      flash[:danger] = "File delete failed."
      redirect_to folio_path
    end
  end

  private

  def upload_params
    params
    .require(:upload).permit(:folder_id, :attachment)
    .merge!({is_private: current_folder.is_private})
  end
end
