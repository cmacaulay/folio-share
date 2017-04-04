module PathsHelper
  def folder_or_upload_path(child)
    if child.class == Upload
      upload_path(current_folder, child)
    elsif child.class == Folder
      folder_path(child)
    end
  end

  def folder_or_folio_path(folder_id)
    folder = current_user.folders.find(folder_id)
    if folder.root_folder?
      folio_path
    else
      folder_path(folder)
    end
  end
end