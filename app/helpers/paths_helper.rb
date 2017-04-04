module PathsHelper
  def folder_or_upload_path(params)
    if params[:child].class == Upload
      upload_path(params[:current_folder], params[:child])
    elsif params[:child].class == Folder
      folder_path(params[:child])
    end
  end

  def folder_or_folio_path(folder_id)
    folder = current_user.folders.find(folder_id)
    if folder.root_folder?
      home_path
    else
      folder_path(folder)
    end
  end
end