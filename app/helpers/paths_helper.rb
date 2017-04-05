module PathsHelper
  def folder_or_upload_path(child)
    if child.class == Upload
      upload_path(current_folder, child)
    elsif child.class == Folder
      folder_path(child)
    end
  end

  def folder_or_folio_path(folder_id)
    folder = Folder.find(folder_id)
    if folder.owner.id == current_user.id
      current_user_owner(folder)
    else
      collaborator(folder)
    end
  end

  def current_user_owner(folder)
    if folder.root_folder?
      folio_path
    else
      folder_path(folder)
    end
  end

  def collaborator(folder)
    shared_path(folder)
  end

  def public_folder_or_upload_path(child)
    if child.class == Upload
      public_upload_path(current_folder, child)
    elsif child.class == Folder
      public_folder_path(child)
    end
  end

  def back_path(default_path)
    if request.referer.nil?
      default_path
    else
      URI(request.referer)
    end
  end

end
